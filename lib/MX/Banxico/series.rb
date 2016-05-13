#
# Series de datos que se pueden obtener de los servicios web del Banco de México (Banxico).
#
#
class MX::Banxico::Series
  
  # Series de reservas internacionales.
  #
  # Series:
  # * :reserva_internacional
  #
  SERIES_RESERVAS_INTERNACIONALES = {
    reserva_internacional: {
      id: "SF43707",
      titulo: "Reserva internacional",
      descripcion: "Reserva internacional en millones de dólares",
      tipo_cifra: "Saldos",
      tipo_unidad: "Millones de dólares"
    }
  }.freeze

  
  # Series de tasas de interés.
  #
  # Series:
  # * :tasa_objetivo
  # * :tasa_interes_interbancaria_tiie_28_dias
  # * :tasa_interes_interbancaria_tiie_91_dias
  # * :tasa_rendimiento_cetes_28_dias
  #
  SERIES_TASAS_DE_INTERES = {
    tasa_objetivo:{
      id: "SF61745",
      titulo: "Tasa objetivo",
      descripcion: "Tasa objetivo"
    },
    tasa_interes_interbancaria_tiie_28_dias: {
      id: "SF60648",
      titulo: "Tasa de interés interbancario TIIE a 28 días",
      descripcion: "Tasa de interés interbancario TIIE a 28 días"
    },
    tasa_interes_interbancaria_tiie_91_dias: {
      id: "SF60649",
      titulo: "Tasa de interés interbancario TIIE a 91 días",
      descripcion: "Tasa de interés interbancario TIIE a 91 días"
    },
    tasa_rendimiento_cetes_28_dias: {
      id: "SF60633",
      titulo: "Tasa de rendimiento resultado de la subasta semanal Cetes a 28 días",
      descripcion: "Tasa de rendimiento resultado de la subasta semanal Cetes a 28 días"
    }
  }.freeze
  
  
  # Series de tipos de cambio.
  #
  # Series:
  # * :dolar_canadiense
  # * :dolar_fix
  # * :dolar_liquidacion
  # * :euro
  # * :libra_esterlina
  # * :yen
  #
  SERIES_TIPOS_DE_CAMBIO = {
    dolar_canadiense: {
      id: "SF60632",
      titulo: "Cotización de las divisas que conforman la canasta del DEG respecto al Peso mexicano vs. el Dólar canadiense",
      descripcion: "Peso mexicano vs. el Dólar canadiense",
      tipo_cifra: "Tipo de cambio",
      tipo_unidad: "Peso mexicano"
    },
    dolar_fix: {
      id: "SF43718",
      titulo: "Tipo de cambio Pesos mexicanos por Dólar E.U.A. para solventar obligaciones en moneda extranjera (fecha de determinación - Fix)",
      descripcion: "Peso mexicano vs. el Dólar E.U.A. (fecha de determinación - Fix)",
      tipo_cifra: "Tipo de cambio",
      tipo_unidad: "Peso por dólar"
    },
    dolar_liquidacion: {
      id: "SF60653",
      titulo: "Tipo de cambio Pesos mexicanos por Dólar E.U.A. para solventar obligaciones en moneda extranjera (fecha de liquidación)",
      descripcion: "Peso mexicano vs. el Dólar E.U.A. (fecha de liquidación)",
      tipo_cifra: "Tipo de cambio",
      tipo_unidad: "Peso por dólar"
    },
    euro: {
      id: "SF46410",
      titulo: "Cotización de las divisas que conforman la canasta del DEG respecto al Peso mexicano vs. el Euro",
      descripcion: "Peso mexicano vs. el Euro",
      tipo_cifra: "Tipo de cambio",
      tipo_unidad: "Peso mexicano"
    },
    libra_esterlina: {
      id: "SF46407",
      titulo: "Cotización de las divisas que conforman la canasta del DEG respecto al Peso mexicano vs. la Libra esterlina",
      descripcion: "Peso mexicano vs. la Libra esterlina",
      tipo_cifra: "Tipo de cambio",
      tipo_unidad: "Peso mexicano"
    },
    yen: {
      id: "SF46406",
      titulo: "Cotización de las divisas que conforman la canasta del DEG respecto al Peso mexicano vs. el Yen japonés",
      descripcion: "Peso mexicano vs. el Yen japonés",
      tipo_cifra: "Tipo de cambio",
      tipo_unidad: "Peso mexicano"
    }
  }.freeze
  
  
  # Series de UDIS ({http://www.banxico.org.mx/ayuda/temas-mas-consultados/udis--unidades-inversion-.html Unidades de Inversión}). 
  #
  # Series:
  # * :udis
  #
  SERIES_UDIS = {
    udis: {
      id: "SP68257",
      titulo: "Valor de UDIS",
      descripcion: "Valor de UDIS",
      tipo_cifra: "Tipo de cambio",
      tipo_unidad: "UDI"
    }
  }.freeze
  
  
  # Tipos de series.
  #
  # Tipos:
  # * :reservas_internacionales
  # * :tasas_de_interes
  # * :tipos_de_cambio
  # * :udis
  #
  TIPOS = {
    reservas_internacionales: SERIES_RESERVAS_INTERNACIONALES,
    tasas_de_interes: SERIES_TASAS_DE_INTERES,
    tipos_de_cambio: SERIES_TIPOS_DE_CAMBIO,
    udis: SERIES_UDIS,
  }.freeze
  
  
  class << self
    
    # Todas las series por tipo.
    #
    # @return [Hash] con el tipo por llave. Cada llave contiene otro `Hash` con las series.
    #
    def todas
      TIPOS
    end
    
    
    # Arreglo con los tipos de series. Ver {TIPOS}.
    #
    # Tipos:
    # * :reservas_internacionales
    # * :tasas_de_interes
    # * :tipos_de_cambio
    # * :udis
    #
    # @return [Array<Symbol>] arreglo con los tipos de series.
    def tipos
      TIPOS.keys
    end
  
    
    # Series de reservas internacionales.
    #
    # Series:
    # * :reserva_internacional
    #
    # @return [Hash] donde cada llave es el nombre de la serie y su valor es otro `Hash`con:
    #   * identificador (`:id`)
    #   * descripción (`:descripcion`)
    #   * título (`:titulo`)
    #   * tipo de la cifra (`:tipo_cifra`), por ejemplo: "Tipo de cambio"
    #   * tipo de la unidad (`:tipo_unidad`), por ejemplo: "Millones de dólares"
    #
    def reservas_internacionales
      SERIES_RESERVAS_INTERNACIONALES
    end
    
    
    # Series de tasas de interés.
    #
    # Series:
    # * :tasa_objetivo
    # * :tasa_interes_interbancaria_tiie_28_dias
    # * :tasa_interes_interbancaria_tiie_91_dias
    # * :tasa_rendimiento_cetes_28_dias
    #
    # @return [Hash] donde cada llave es el nombre de la serie y su valor es otro `Hash`con:
    #   * identificador (`:id`)
    #   * descripción (`:descripcion`)
    #   * título (`:titulo`)
    #
    def tasas_de_interes
      SERIES_TASAS_DE_INTERES
    end

  
    # Series de tipos de cambio.
    #
    # Series:
    # * :dolar_canadiense
    # * :dolar_fix
    # * :dolar_liquidacion
    # * :euro
    # * :libra_esterlina
    # * :yen
    #
    # @return [Hash] donde cada llave es el nombre de la serie y su valor es otro `Hash`con:
    #   * identificador (`:id`)
    #   * descripción (`:descripcion`)
    #   * título (`:titulo`)
    #   * tipo de la cifra (`:tipo_cifra`), por ejemplo: "Tipo de cambio"
    #   * tipo de la unidad (`:tipo_unidad`), por ejemplo: "Millones de dólares"
    #
    def tipos_de_cambio
      SERIES_TIPOS_DE_CAMBIO
    end
    
    
    # Series de UDIS ({http://www.banxico.org.mx/ayuda/temas-mas-consultados/udis--unidades-inversion-.html Unidades de Inversión}). 
    #
    # Series:
    # * :udis
    #
    # @return [Hash] donde cada llave es el nombre de la serie y su valor es otro `Hash`con:
    #   * identificador (`:id`)
    #   * descripción (`:descripcion`)
    #   * título (`:titulo`)
    #   * tipo de la cifra (`:tipo_cifra`), por ejemplo: "Tipo de cambio"
    #   * tipo de la unidad (`:tipo_unidad`), por ejemplo: "Millones de dólares"
    #
    def udis
      SERIES_UDIS
    end
    
    
    # Obtiene el identificador de acuerdo al tipo y a la serie.
    # 
    # @param tipo [Symbol] el tipo de la serie (ver {TIPOS} o {.tipos}).
    # @param serie [Symbol] el nombre de la serie.
    #
    # @return [String] el identificador de la serie.
    #
    # @raise [ArgumentError] si `tipo` no existe (no es una llave en {TIPOS} o un elemento de {.tipos}).
    # @raise [ArgumentError] si `serie` no existe.
    # 
    def identificador(tipo, serie)
      raise ArgumentError.new("El tipo no existe (tipo: #{tipo}).") unless TIPOS.has_key?(tipo.to_sym)
      raise ArgumentError.new("La serie no existe (serie: #{serie}).") unless send(tipo.to_sym).has_key?(serie.to_sym)
      send(tipo.to_sym)[serie.to_sym][:id]
    end
    
    
    # Obtiene una lista de identificadores de las series.
    #
    # Cuando se especifica el `tipo`, la lista de identificadores se limita a los de las series de ese `tipo` únicamente.
    # 
    # @param tipo [Symbol] el tipo de la serie (ver {TIPOS} o {.tipos}).
    #
    # @return [Array<String>] arreglo de identificadores.
    #
    # @raise [ArgumentError] si `tipo` no existe (no es una llave en {TIPOS} o un elemento de {.tipos}).
    #
    def identificadores(tipo = nil)
      if tipo.nil?
        TIPOS.inject([]){ |arr, tipo_serie| arr << tipo_serie.last.values.each.map{ |s| s[:id] } }.flatten
      else
        raise ArgumentError.new("El tipo no existe (tipo: #{tipo}).") unless TIPOS.has_key?(tipo.to_sym)
        send(tipo.to_sym).values.map{ |v| v[:id] }
      end
    end
    
    
    # Obtiene el nombre de la serie de acuerdo al identificador dado.
    #
    # Cuando se especifica el `tipo`, la búsqueda del nombre se limita a los de las series de ese `tipo` únicamente.
    # 
    # @param identificador [String] identificador de la serie.
    # @param tipo [Symbol] el tipo de la serie (ver {TIPOS} o {.tipos}).
    #
    # @return [String] el nombre de la serie.
    #
    # @raise [ArgumentError] si `tipo` no existe (no es una llave en {TIPOS} o un elemento de {.tipos}).
    # @raise [ArgumentError] si `identificador` no existe.
    #  
    def nombre(identificador, tipo = nil)
      nom = nil
      if tipo.nil?
        tipos.each do |t|
          nom = busca_nombre(identificador, t)
          break unless nom.nil?
        end
        raise ArgumentError.new("El identificador no existe (identificador: #{identificador}).") if nom.nil?
      else
        nom = busca_nombre(identificador, tipo)
        raise ArgumentError.new("El identificador (identificador: #{identificador}) no se encuentra en el tipo de serie dado (tipo: #{tipo}).") if nom.nil?
      end
      nom
    end
    
    
    # Obtiene una lista de nombres de las series.
    #
    # Cuando se especifica el `tipo`, la lista de nombres se limita a los de las series de ese `tipo` únicamente.
    # 
    # @param tipo [Symbol] el tipo de la serie (ver {TIPOS} o {.tipos}).
    #
    # @return [Array<String>] arreglo de nombres.
    #
    # @raise [ArgumentError] si `tipo` no existe (no es una llave en {TIPOS} o un elemento de {.tipos}).
    #
    def nombres(tipo = nil)
      if tipo.nil?
        TIPOS.inject([]){ |arr, tipo_serie| arr << tipo_serie.last.keys }.flatten
      else
        raise ArgumentError.new("El tipo no existe (tipo: #{tipo}).") unless TIPOS.has_key?(tipo.to_sym)
        send(tipo.to_sym).keys
      end
    end
  
    private
      
      # Busca el nombre de acuerdo al identificador y el tipo dado.
      #
      # @param identificador [String] identificador de la serie.
      # @param tipo [Symbol] el tipo de la serie (ver {TIPOS} o {.tipos}).
      #
      # @return [String] si el nombre de la serie fue encontrado.
      # @return [nil] si el nombre de la serie no fue encontrado.
      #
      # @raise [ArgumentError] si `tipo` no existe (no es una llave en {TIPOS} o un elemento de {.tipos}).
      #
      def busca_nombre(identificador, tipo)
        raise ArgumentError.new("El tipo no existe (tipo: #{tipo}).") unless TIPOS.has_key?(tipo.to_sym)
        send(tipo.to_sym).each_pair{|k, v| return k if v[:id] == identificador }
        nil
      end
  end
  
  
end