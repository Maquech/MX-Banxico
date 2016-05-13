# Estructura para guardar el tipo de cambio de una fecha.
#
class MX::Banxico::TipoDeCambio
  # !@attribute [r] moneda
  #   @return [Symbol] el nombre de la moneda de origen.
  attr_reader :moneda
  
  
  # !@attribute [r] fecha
  #   @return [Date] la fecha del tipo de cambio.
  attr_reader :fecha
  
  
  # !@attribute [r] valor_en_mxn
  #   @return [Float] el importe en pesos mexicanos (MXN) del tipo de cambio.
  attr_reader :valor_en_mxn
  
  
  # Constructor.
  #
  # @param moneda [String, Symbol] el nombre de la moneda de origen.
  # @param fecha [String, Date] la fecha del tipo de cambio. Cuando es una cadena debe estar
  #   en formato {http://www.iso.org/iso/home/standards/iso8601.htm ISO-8601}.
  # @param valor_en_mxn [String, Float] el importe en pesos mexicanos (MXN) del tipo de cambio.
  #
  # @return [MX::Banxico::TipoDeCambio] una instancia de la clase.
  #
  # @raise [ArgumentError] cuando alguno de los parámetros no es valido.
  #
  def initialize(moneda, fecha, valor_en_mxn)
    procesar_moneda(moneda)
    procesar_fecha(fecha)
    procesar_valor_en_mxn(valor_en_mxn)
  end
  
  
  # La representación en cadena de la instancia.
  #
  # @return [String] La representación en cadena de la instancia.
  #
  def to_s
    "#{@moneda}: #{"$%.4f MXN" % @valor_en_mxn} al día #{@fecha.to_s}"
  end
  
  
  # Compara `self` con `otro`.
  #
  # @param otro [MX::Banxico::TipoDeCambio] la instancia contra la que se realizará la comparación.
  #
  # @return [Integer]
  #  * `1` si `self` es mayor que `otro`
  #  * `0` si `self` es igual a `otro`
  #  * `-1` si `self` es menor que `otro`
  #
  def <=>(otro)
    if self == otro
      0
    elsif @moneda == otro.moneda
      if @fecha == otro.fecha
        @valor_en_mxn <=> otro.valor_en_mxn
      elsif @fecha < otro.fecha
        -1
      else
        1
      end
    elsif @moneda < otro.moneda
      -1
    else
      1
    end
  end
  
  
  # Indica si `self` y `otro` son iguales.
  #
  # @param otro [MX::Banxico::TipoDeCambio] la instancia contra la que se realizará la comparación.
  #
  # @return [Boolean] `true` si `self` es igual a `otro`, `false` de lo contrario.
  #
  def ==(otro)
    @moneda == otro.moneda && @fecha == otro.fecha && @valor_en_mxn == otro.valor_en_mxn
  end
  
  
  
  private
  
  # Mensaje para la excepción al convertir la fecha.
  #
  FECHA_EX_MSG = "fecha debe ser una cadena (String) en formato ISO-8601 o un objeto de tipo fecha (Date)."
  
  # Mensaje para la excepción al convertir el valor en pesos.
  #
  VALOR_EN_MXN_EX_MSG = "valor_en_mxn debe ser una cadena con un número decimal o un objeto de tipo (Float)."
  
  
  # Verifica que la moneda sea del tipo adecuado y de ser posible, la convierte a un símbolo (Symbol) y asigna
  # el valor a la variable `moneda` de la instancia.
  #
  # @param moneda [String, Symbol] el nombre de la moneda de origen.
  #
  # @raise [ArgumentError] cuando no tiene el tipo correcto el parámetro `moneda`.
  #
  def procesar_moneda(moneda)
    if moneda.is_a?(String)
      @moneda = moneda.to_sym
    elsif moneda.is_a?(Symbol)
      @moneda = moneda
    else
      raise ArgumentError.new("moneda debe ser una cadena (String) o un objeto tipo símbolo (Symbol).")
    end
  end
  
  
  # Verifica que la fecha sea del tipo adecuado y de ser posible, la convierte a un objeto de tipo fecha (Date) y asigna
  # el valor a la variable `fecha` de la instancia.
  #
  # @param fecha [String, Date] la fecha del tipo de cambio. Cuando es una cadena debe estar
  #   en formato {http://www.iso.org/iso/home/standards/iso8601.htm ISO-8601}.
  #
  # @raise [ArgumentError] cuando no tiene el tipo o formato correcto el parámetro `fecha`.
  #
  def procesar_fecha(fecha)
    if fecha.is_a?(Date)
      @fecha = fecha
    elsif fecha.is_a?(String)
      begin
        @fecha = Date.iso8601(fecha)
      rescue ArgumentError
        raise ArgumentError.new(FECHA_EX_MSG)
      end
    else
      raise ArgumentError.new(FECHA_EX_MSG)
    end
  end
  
  
  # Verifica que el valor en pesos mexicanos sea del tipo adecuado y de ser posible,
  # lo convierte a un número flotante (Float) y asigna el valor a la variable `valor_en_mxn` de la instancia.
  #
  # @param valor_en_mxn [String, Float] el importe en pesos mexicanos (MXN) del tipo de cambio.
  #
  # @raise [ArgumentError] cuando no tiene el tipo o formato correcto el parámetro `valor_en_mxn`.
  #
  def procesar_valor_en_mxn(valor_en_mxn)
    if valor_en_mxn.is_a?(Float)
      @valor_en_mxn = valor_en_mxn
    elsif valor_en_mxn.is_a?(String)
      if valor_en_mxn =~ /^\d+(\.\d+)?$/
        @valor_en_mxn = valor_en_mxn.to_f
      else
        raise ArgumentError.new(VALOR_EN_MXN_EX_MSG)
      end
    else
      raise ArgumentError.new(VALOR_EN_MXN_EX_MSG)
    end
  end
  
end