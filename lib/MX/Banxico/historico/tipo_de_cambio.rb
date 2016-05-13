# Clase para recuperar series históricas del tipo de cambio.
#
# La información se obtiene de la página de
# {http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?accion=consultarSeries Banxico},
# haciendo una petición POST que simula una consulta
# realizada por un usuario desde un navegador web.
#
class MX::Banxico::Historico::TipoDeCambio
  include HTTParty
  
  
  # URL de la página del Banco de México (Banxico).
  #
  URL = "www.banxico.org.mx"
  
  
  # Ruta para realizar la petición POST para obtener la información.
  #
  POST_PATH = "/SieInternet/consultarDirectorioInternetAction.do?accion=consultarSeries"
  
  
  # Año inicial de la consulta (por omisión).
  #
  AÑO_INICIO_CONSULTA = 2015
  
  
  # Año final de la consulta (por omisión).
  #
  AÑO_FINAL_CONSULTA = 2015
  
  
  # Tipos de cambio soportados.
  #
  TIPOS_DE_CAMBIO = MX::Banxico::Series.tipos_de_cambio.keys.dup.freeze
  
  
  # !@method base_uri
  # URI base para la clase que incluye a {https://github.com/jnunemaker/httparty HTTParty}.
  #
  base_uri URL
  
  
  # !@method open_timeout
  # tiempo de espera para abrir la conexión para clase que incluye a {https://github.com/jnunemaker/httparty HTTParty}.
  #
  open_timeout 10
  
  
  # !@method format
  # formato esperado de la respuesta {https://github.com/jnunemaker/httparty HTTParty}.
  #
  format :xml
  
  
  # !@attribute [r] errores.
  #   @return [String] la descripción de los errores sucedidos al recuperar el histórico.
  attr_reader :errores
  
  
  # Inicializador de la instancia.
  #
  def initialize
    @errores = nil
  end
  
  # Indica si hay algún errror.
  #
  # @return [Boolean] `true` si hay errores, `false` de lo contrario.
  #
  def errores?
    !@errores.nil?
  end
  
  
  # Recupera el histórico de una serie de tipo de cambio de acuerdo al identificador o nombre de la serie dada.
  #
  # @param serie [Symbol] el nombre de la serie de la que se desea recuperar el histórico.
  # @param año_inicio_consulta [Integer] año de inicio de la consulta.
  # @param año_termino_consulta [Integer] año de término de la consulta.
  #
  # @return [Array<MX::Banxico::TipoDeCambio>] si se recuperó la información, un arreglo con los tipos de cambio de la serie.
  # @return [nil] si hubo un error al recuperar la información.
  #
  def de_serie(serie, año_inicio_consulta = nil, año_termino_consulta = nil)
    begin
      id_serie = MX::Banxico::Series.identificador(:tipos_de_cambio, serie)
      opts = { id_serie: id_serie, serie: serie }
      return peticion_post(body_hash(id_serie, año_inicio_consulta, año_termino_consulta), opts)
    rescue ArgumentError => e
      registrar_error(e.message)
    end
    nil
  end
  
  
  # Recupera todos los históricos de las series de tipo de cambio en {MX::Banxico::Series.tipos_de_cambio}.
  #
  # @param año_inicio_consulta [Integer] año de inicio de la consulta.
  # @param año_termino_consulta [Integer] año de término de la consulta.
  #
  # @return [Array<MX::Banxico::TipoDeCambio>] si se recuperó la información, un arreglo con los tipos de cambio de la serie.
  # @return [nil] si hubo un error al recuperar la información.
  #
  def completo(año_inicio_consulta = nil, año_termino_consulta = nil)
    opts = { ids_series: MX::Banxico::Series.identificadores(:tipos_de_cambio) }
    body_str = hash_a_query_string(body_hash(opts[:ids_series], año_inicio_consulta, año_termino_consulta))
    return peticion_post(body_str, opts)
  end
  
  
  
  private
    
    # Realiza la petición POST de acuerdo al cuerpo dado.
    #
    # @param body [Hash, String] el cuerpo de la petición. Usamos una cadena
    #  cuando algún parámetro tiene como valor un arreglo, de lo contrario se usa un `Hash`.
    # @param opts [Hash] información adicional para procesar la respuesta.
    #
    # @return [Array<MX::Banxico::TipoDeCambio>] si se recuperó la información, un arreglo con los tipos de cambio de la serie.
    # @return [nil] si hubo un error al recuperar la información.
    #
    def peticion_post(body, opts = {})
      respuesta = self.class.post(POST_PATH, headers: header_hash, body: body)
      return procesar_respuesta(respuesta.body, opts) if respuesta.code == 200
      registrar_error("código de error #{respuesta.code}.")
      nil
    end
    
    
    # Procesa la respuesta de la petición, que es un `Hash` generado por {https://github.com/jnunemaker/httparty HTTParty}.
    # 
    # @param respuesta [String] la respuesta de la petición realizada.
    # @param opts [Hash] información adicional para procesar la respuesta.
    #
    # @return [Array<MX::Banxico::TipoDeCambio>] si no hubo errores, un arreglo con los tipos de cambio encontrados en la respuesta.
    # @return [nil] si hubo un error al recuperar la información.
    #
    def procesar_respuesta(respuesta, opts = {})
      xml_doc = Nokogiri::XML(respuesta, nil, 'UTF-8')
      if xml_doc.root.respond_to?(:xpath)
        if opts[:id_serie] && opts[:serie]
          return procesar_serie(xml_doc, opts[:id_serie], opts[:serie])
        else
          return procesar_series(xml_doc, opts[:ids_series])
        end
      else
        registrar_error("La respuesta de la petición no tiene el formato correcto.")
      end
      nil
    end
    
    
    # Procesa el XML, buscando la serie del identificador dado.
    # 
    # @param xml_doc [Nokogiri::XML::Document] el XML con la respuesta de la petición realizada.
    # @param id_serie [String] el identificador de la serie.
    # @param serie [Symbol] el nombre de la serie.
    #
    # @return [Array<MX::Banxico::TipoDeCambio>] si no hubo errores, un arreglo con los tipos de cambio encontrados en la respuesta.
    # @return [nil] si hubo un error al recuperar la información.
    #
    def procesar_serie(xml_doc, id_serie, serie)
      historico = procesar_nodos_obs(xml_doc.root.xpath(%Q{bm:DataSet/bm:Series[@IDSERIE="#{id_serie}"]/bm:Obs}), serie)
      return historico unless historico.empty?
      registrar_error("No se encontró información de la serie #{serie} dentro de la respuesta de la petición.")
      nil
    end
    
    
    # Procesa el XML de las series encontradas.
    # 
    # @param xml_doc [Nokogiri::XML::Document] el XML con la respuesta de la petición realizada.
    #
    # @return [Array<MX::Banxico::TipoDeCambio>] si no hubo errores, un arreglo con los tipos de cambio encontrados en la respuesta.
    # @return [nil] si hubo un error al recuperar la información.
    #
    def procesar_series(xml_doc, ids_series)
      historico = []
      xml_doc.root.xpath("bm:DataSet/bm:Series").each do |serie|
        if serie["IDSERIE"] && ids_series.include?(serie["IDSERIE"])
          begin
            nombre_serie = MX::Banxico::Series.nombre(serie["IDSERIE"], :tipos_de_cambio)
            historico += procesar_nodos_obs(serie.xpath("bm:Obs"), nombre_serie)
          rescue ArgumentError # no se encontró el nombre de la serie
          rescue Nokogiri::XML::XPath::SyntaxError # no jaló el xpath
          end
        end
      end
      return historico.sort unless historico.empty?
      registrar_error("No se encontraron series en la respuesta.")  
      nil
    end
    
    
    # Procesa los nodos XML de la respuesta de la petición que contiene la información del tipo de cambio.
    #
    # @param nodos_obs [Nokogiri::XML::Nodes] nodos de la serie con el valor y fecha del tipo de cambio (bm:Obs).
    # @param nombre_serie [Symbol] el nombre tipo de cambio solicitado. Ver {TIPOS_DE_CAMBIO}.
    #
    # @return [Array<MX::Banxico::TipoDeCambio>] los valores del tipo de cambio.
    #
    def procesar_nodos_obs(nodos_obs, nombre_serie)
      historico = []
      nodos_obs.each do |nodo_obs|
        begin
          tdc = MX::Banxico::TipoDeCambio.new(nombre_serie, nodo_obs[:TIME_PERIOD], nodo_obs[:OBS_VALUE])
          historico << tdc
        rescue ArgumentError
        end
      end
      historico
    end
    
    
    # Registra el mensaje de error en {#errores}.
    #
    # @param error [String] el error que se agregará a {#errores}
    # @param desc [String] descripción del error.
    #
    # @return [String] la nueva cadena de error.
    #
    def registrar_error(error, desc = nil)
      err = "Error#{(desc.nil? or desc.empty?) ? "" : " (#{desc})"}: #{error}"
      @errores = errores? ? "#{@errores} #{err}" : err
    end
    
    
    # Encabezado para la petición POST para recuperar el histórico de las series.
    #
    # @return [Hash] con los valores para el encabezado de la petición POST.
    #
    def header_hash
      { "Content-Type" => "application/x-www-form-urlencoded" }
    end
    
    
    # Crea el cuerpo para la petición POST para recuperar el histórico de las series.
    #
    # @param serie [String, Array<String>] el identificador o arreglo de identificadores de la serie o series
    #   de la que se desea recuperar el histórico.
    # @param año_inicio_consulta [Integer] año de inicio de la consulta.
    # @param año_termino_consulta [Integer] año de término de la consulta.
    #
    # @return [Hash] con los valores para el cuerpo de la petición POST.
    #
    def body_hash(serie, año_inicio_consulta = nil, año_termino_consulta = nil)
      { # Información recuparada de la petición POST al descargar desde la página web
        idCuadro: "CF102",
        sector: "6",
        version: "2",
        locale: "es",
        "formatoSDMX.x" => "41",
        "formatoSDMX.y" => "8",
        formatoHorizontal: false,
        metadatosWeb: true,
        tipoInformacion: nil,
        # años de consulta
        anoInicial: año_inicio_consulta || AÑO_INICIO_CONSULTA,
        anoFinal: año_termino_consulta || AÑO_FINAL_CONSULTA,
        # las series a descargar en la consulta
        series: serie
      }
    end
    
    
    # Convierte un `Hash` a una cadena de petición HTTP.
    #
    # @example Conversión del `Hash`
    #   hsh = { un_param: "foo", otro_param: "bar", param_arreglo: ["a", "b"] }
    #   hash_a_query_string(hsh) #=> "un_param=foo&otro_param=bar&param_arreglo=a&param_arreglo=b"
    #
    #
    # @param hsh [Hash] el `Hash` a convertir a cadena.
    #
    # @return [String] la cadena de petición.
    def hash_a_query_string(hsh)
      pares = []
      hsh.each_pair do |k,v|
        v.is_a?(Array) ? v.each{ |val| pares << par_query_string(k, val) } : pares << par_query_string(k, v)
      end
      pares.join("&")
    end
    
    
    # Crea un par de llave y valor escapado para URIs.
    #
    # @param llave [String, Symbol] la llave del par.
    # @param valor [String, Symbol] el valor del par.
    #
    # @return [String] el par escapado para URI.
    #
    def par_query_string(llave, valor)
      "#{URI.escape llave.to_s}=#{URI.escape valor.to_s}"
    end
end
