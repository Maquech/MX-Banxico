# Modelo para conectarse al servicio web de Banxico y obtener los tipos de cambio vigentes al día de hoy.
#
# Esta clase hereda de {MX::Banxico::WebServices::WebService} para especializarse en la recuperación de los tipos de cambio.
#
class MX::Banxico::WebServices::TipoDeCambio < MX::Banxico::WebServices::WebService
  
  
  # Tipos de cambio soportados.
  #
  TIPOS_DE_CAMBIO = MX::Banxico::Series.tipos_de_cambio.keys.dup.freeze
  
  # Inicialización del cliente de {http://savonrb.com/version2/testing.html Savon}.
  #
  self.init_client
  
  # @!method operations
  # Operaciones soportadas en este web service via {http://savonrb.com/version2/testing.html Savon}.
  #
  operations :tipos_de_cambio_banxico

  
  # Obtiene el tipo de cambio del día.
  #
  # @param tipo [Symbol] el tipo de cambio deseado. Ver {TIPOS_DE_CAMBIO}.
  # @param intentos [Ingeger] el número de intentos para obtener el tipo de cambio.
  #
  # @return [MX::Banxico::TipoDeCambio] si la petición es exitosa, la estructura con el tipo de cambio.
  # @return [String] si la petición no es exitosa, una cadena con la descripción del error.
  #
  # @raise [ArgumentError] cuando el tipo dado no está soportado. Ver {TIPOS_DE_CAMBIO}.
  #
  def obtener(tipo, intentos = 5)
    raise ArgumentError.new("El tipo de cambio no está soportado (#{tipo}).") unless TIPOS_DE_CAMBIO.member?(tipo.to_sym)
    respuesta = realizar_operacion(:tipos_de_cambio_banxico, intentos)
    if respuesta.errores?
      return respuesta.errores
    else
      xml_doc_cuerpo_respuesta = Nokogiri::XML(respuesta.cuerpo, nil, CODIFICACION_WS )
      nodo_valor = xml_doc_cuerpo_respuesta.root.at_xpath(xpath_tipo_de_cambio(tipo))
      if nodo_valor
        tdc_o_error = procesar_nodo_obs_tipo_de_cambio(nodo_valor, tipo)
        return tdc_o_error
      else
        return "No fue posible extraer los valores del XML del nodo bm:Obs al consultar el servicio web." +
          " Operación: #{:tipos_de_cambio_banxico}. XPath: #{xpath_tipo_de_cambio(tipo)}." +
          "\n\n #{respuesta.cuerpo}"
      end
    end
  end



  private
    
    # Procesa el nodo del XML de la respuesta de la petición que contiene la información del tipo de cambio.
    #
    # @param nodo_valor [Nokogiri::XML::Node] nodo de la serie con el valor y fecha del tipo de cambio (bm:Obs).
    # @param tipo [Symbol] el tipo de cambio solicitado. Ver {TIPOS_DE_CAMBIO}.
    #
    # @return [MX::Banxico::TipoDeCambio] si la obtención del valor y la fecha es exitosa, la estructura con el tipo de cambio.
    # @return [String] si la obtención del valor y la fecha no es exitosa, una cadena con la descripción del error.
    #
    def procesar_nodo_obs_tipo_de_cambio(nodo_valor, tipo)
      begin
        return MX::Banxico::TipoDeCambio.new(tipo, nodo_valor[:TIME_PERIOD], nodo_valor[:OBS_VALUE])
      rescue ArgumentError => e
        return "Error al crear el tipo de cambio a partir del nodo bm:Obs. Error: #{e.message}"
      end
    end

    # XPath con la ruta del nodo `bm:Obs` del identificador de la serie de acuerdo a su tipo.
    #
    # @param tipo [Symbol] el tipo de cambio solicitado. Ver {TIPOS_DE_CAMBIO}.
    #
    # @return [String] la ruta (XPath) del nodo de la serie de acuerdo al tipo dado.
    #
    def xpath_tipo_de_cambio(tipo)
      id = MX::Banxico::Series.identificador(:tipos_de_cambio, tipo)
      %Q{bm:DataSet/bm:Series[@IDSERIE="#{id}"]/bm:Obs}
    end


end