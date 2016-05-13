#
# Modelo para conectarse al servicio web de Banxico por medio de Savon::Model.
#
#
# @note Savon crea métodos por omisión de acuerdo a las operaciones soportadas por el servicio web, tano a nivel
#   de clase como de instancia.
#
class MX::Banxico::WebServices::WebService
  extend Savon::Model
  
  
  # Estructura para guardar el cuerpo de la respuesta de una operación o los errores
  #
  Respuesta = Struct.new(:cuerpo, :errores) do
    
    # Determina si la operación fue exitosa.
    #
    # @return `true` si tuvo éxito, `false` de lo contrario.
    #
    def exito?
      errores.nil?
    end
    
    # Determina si hubo errores en al efectuar la operación.
    #
    # @return `true` si hubieron errores, `false` de lo contrario.
    #
    def errores?
      !exito?
    end
    
  end
  
  
  # URL con la definición del servicio web.
  #
  WSDL = "http://www.banxico.org.mx/DgieWSWeb/DgieWS?WSDL"

  # Codificación de la petición y respuesta del servicio
  # ¡guácala, no es UTF-8 la codificación que manejan en Banxico!
  #
  CODIFICACION_WS = "ISO-8859-1"
  

  # Operaciones soportadas por el servicio web de Banxico:
  # * Reservas internacionales
  # * Tasas de interés
  # * Tipos de Cambio
  # * UDIS
  #
  OPERACIONES_WS = [ :reservas_internacionales_banxico, :tasas_de_interes_banxico, :tipos_de_cambio_banxico, :udis_banxico ]

  # @!method client
  # Definición del cliente de Savon
  #
  
  # Inicializa el cliente de Savon.
  #
  def self.init_client
    client wsdl: WSDL, encoding: CODIFICACION_WS, open_timeout: 5, read_timeout: 5
  end
  
  # Inicialización del cliente de Savon
  #
  self.init_client
  
  # Realiza la operación solicitada en un máximo de intentos dados.
  #
  # @param op [Symbol] el nombre de la operación soportada a efectuarse. Ver {OPERACIONES_WS}.
  # @param intentos [Fixnum] el número de intentos en los que se tratará de recuperar la respuesta de la operación.
  #
  # @return [Hash] con el cuerpo de la respuesta de la operación en la llave `:cuerpo` o una descripción de los errores
  #   ocurridos  en la llave `:errores`.
  #
  def realizar_operacion(op, intentos = 5)
    raise ArgumentError.new("La operación #{op} no está soportada.") unless OPERACIONES_WS.member?(op.to_sym)
    raise ArgumentError.new("El número de intentos debe ser mayor o igual a 1.") if (!intentos.is_a?(Integer) or intentos < 1)
    errores = ""
    1.upto(intentos) do |intento|
      begin
        resp = client.call(op.to_sym)
        return Respuesta.new(resp.body[:"#{op}_response"][:result]) if resp.success?
      rescue Exception => e
        errores = "#{errores}Intento #{intento}: #{e.message}. "
      end
      errores = "#{errores}Número de intentos agotados #{intentos}." if intento == intentos
    end
    Respuesta.new(nil, errores)
  end
  
  # Arreglo con las operaciones soportadas por el servicio web.
  #
  # @return [Array] un arreglo con las operaciones soportados.
  #
  def self.operaciones
    OPERACIONES_WS
  end
  
end