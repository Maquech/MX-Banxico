require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe MX::Banxico::Series, :series do
  
  
  describe '.tipos' do
    
    it 'es un arreglo de símbolos con los nombres de los tipos de series' do
      expect(described_class.tipos).to be_a Array
    end
    
    it 'tiene un elemento :reservas_internacionales' do
      expect(described_class.tipos).to include :reservas_internacionales
    end
    
    it 'tiene un elemento :tasas_de_interes' do
      expect(described_class.tipos).to include :tasas_de_interes
    end
    
    it 'tiene un elemento :tipos_de_cambio' do
      expect(described_class.tipos).to include :tipos_de_cambio
    end
    
    it 'tiene un elemento :udis' do
      expect(described_class.tipos).to include :udis
    end
    
  end
  
  
  describe '.todas' do
    
    it 'es un Hash de Hashes con los tipos de series como llave' do
      expect(described_class.todas).to be_a Hash
    end
    
    it 'es la constante TIPOS' do
      expect(described_class.todas).to eq described_class::TIPOS
    end
    
  end
  
  
  describe '.reservas_internacionales' do
    
    it 'es un Hash de Hashes con el nombre de la serie como llave' do
      expect(described_class.reservas_internacionales).to be_a Hash
    end
    
    it 'es la constante SERIES_RESERVAS_INTERNACIONALES' do
      expect(described_class.reservas_internacionales).to eq described_class::SERIES_RESERVAS_INTERNACIONALES
    end
    
    
    describe 'tiene las series' do
      
      context 'Reserva internacional' do
        
        it 'tiene la llave :reservas_internacionales' do
          expect(described_class.reservas_internacionales).to have_key :reserva_internacional
        end

        it 'tiene el identificador SF43707' do
          expect(described_class.reservas_internacionales[:reserva_internacional][:id]).to eq "SF43707" 
        end
        
      end
      
    end
    
  end
  
  
  describe '.tasas_de_interes' do
    
    it 'es un Hash de Hashes con el nombre de la serie como llave' do
      expect(described_class.tasas_de_interes).to be_a Hash
    end
    
    it 'es la constante SERIES_TASAS_DE_INTERES' do
      expect(described_class.tasas_de_interes).to eq described_class::SERIES_TASAS_DE_INTERES
    end
    
    
    describe 'tiene las series' do
      
      context 'Tasa objetivo' do
        
        it 'tiene la llave :tasa_objetivo' do
          expect(described_class.tasas_de_interes).to have_key :tasa_objetivo
        end

        it 'tiene el identificador SF61745' do
          expect(described_class.tasas_de_interes[:tasa_objetivo][:id]).to eq "SF61745" 
        end
        
      end
      
      
      context 'Tasa interbancaria TIEE 28 días' do
        
        it 'tiene la llave :tasa_interes_interbancaria_tiie_28_dias' do
          expect(described_class.tasas_de_interes).to have_key :tasa_interes_interbancaria_tiie_28_dias
        end

        it 'tiene el identificador SF60648' do
          expect(described_class.tasas_de_interes[:tasa_interes_interbancaria_tiie_28_dias][:id]).to eq "SF60648" 
        end
        
      end
      
      
      context 'Tasa interbancaria TIEE 91 días' do
        
        it 'tiene la llave :tasa_interes_interbancaria_tiie_91_dias' do
          expect(described_class.tasas_de_interes).to have_key :tasa_interes_interbancaria_tiie_91_dias
        end

        it 'tiene el identificador SF60649' do
          expect(described_class.tasas_de_interes[:tasa_interes_interbancaria_tiie_91_dias][:id]).to eq "SF60649" 
        end
        
      end
      
      
      context 'Tasa rendimiento cetes a 28 días' do
        
        it 'tiene la llave :tasa_rendimiento_cetes_28_dias' do
          expect(described_class.tasas_de_interes).to have_key :tasa_rendimiento_cetes_28_dias
        end

        it 'tiene el identificador SF60633' do
          expect(described_class.tasas_de_interes[:tasa_rendimiento_cetes_28_dias][:id]).to eq "SF60633" 
        end
        
      end
      
    end
    
  end
  
  
  describe '.tipos_de_cambio' do
    
    it 'es un Hash de Hashes con el nombre de la serie como llave' do
      expect(described_class.tipos_de_cambio).to be_a Hash
    end
    
    it 'es la constante SERIES_TIPOS_DE_CAMBIO' do
      expect(described_class.tipos_de_cambio).to eq described_class::SERIES_TIPOS_DE_CAMBIO
    end
    
    
    describe 'tiene las series' do
      
      context 'Dólar canadiense' do
        
        it 'tiene la llave :dolar_canadiense' do
          expect(described_class.tipos_de_cambio).to have_key :dolar_canadiense
        end

        it 'tiene el identificador SF60632' do
          expect(described_class.tipos_de_cambio[:dolar_canadiense][:id]).to eq "SF60632" 
        end
        
      end
      
      
      context 'Dólar fix' do
        
        it 'tiene la llave :dolar_fix' do
          expect(described_class.tipos_de_cambio).to have_key :dolar_fix
        end

        it 'tiene el identificador SF43718' do
          expect(described_class.tipos_de_cambio[:dolar_fix][:id]).to eq "SF43718" 
        end
        
      end
      
      
      context 'Dólar liquidación' do
        
        it 'tiene la llave :dolar_liquidacion' do
          expect(described_class.tipos_de_cambio).to have_key :dolar_liquidacion
        end

        it 'tiene el identificador SF60653' do
          expect(described_class.tipos_de_cambio[:dolar_liquidacion][:id]).to eq "SF60653" 
        end
        
      end
      
      
      context 'Euro' do
        
        it 'tiene la llave :euro' do
          expect(described_class.tipos_de_cambio).to have_key :euro
        end

        it 'tiene el identificador SF46410' do
          expect(described_class.tipos_de_cambio[:euro][:id]).to eq "SF46410" 
        end
        
      end
      
      
      context 'Libra esterlina' do
        
        it 'tiene la llave :libra_esterlina' do
          expect(described_class.tipos_de_cambio).to have_key :libra_esterlina
        end

        it 'tiene el identificador SF46407' do
          expect(described_class.tipos_de_cambio[:libra_esterlina][:id]).to eq "SF46407" 
        end
        
      end
      
      
      context 'Yen' do
        
        it 'tiene la llave :yen' do
          expect(described_class.tipos_de_cambio).to have_key :yen
        end

        it 'tiene el identificador SF46406' do
          expect(described_class.tipos_de_cambio[:yen][:id]).to eq "SF46406" 
        end
      end
      
    end
    
  end
  
  
  describe '.udis' do
    
    it 'es un Hash de Hashes con el nombre de la serie como llave' do
      expect(described_class.udis).to be_a Hash
    end
    
    it 'es la constante SERIES_UDIS' do
      expect(described_class.udis).to eq described_class::SERIES_UDIS
    end
    
    describe 'tiene las series' do
      
      context 'UDIS' do
        
        it 'tiene la llave :udis' do
          expect(described_class.udis).to have_key :udis
        end

        it 'tiene el identificador SP68257' do
          expect(described_class.udis[:udis][:id]).to eq "SP68257" 
        end
        
      end
      
    end
    
  end
  
  
  describe '.identificador' do
    
    context 'cuando el tipo dado no existe' do
      it 'levanta una excepción' do
        tipo = :tipo_inexistente
        expect { described_class.identificador(tipo, :dolar_fix) }.to raise_error(ArgumentError, "El tipo no existe (tipo: #{tipo}).")
      end
    end
    
    context 'cuando la serie dada no existe' do
      it 'levanta una excepción' do
        serie = :serie_inexistente
        expect { described_class.identificador(:tipos_de_cambio, serie) }.to raise_error(ArgumentError, "La serie no existe (serie: #{serie}).")
      end
    end
    
    context 'cuando el tipo y la serie dados existen' do
      
      it 'es el identificador de la serie dada' do
        expect(described_class.identificador(:tipos_de_cambio, :dolar_fix)).to eq "SF43718"
      end
      
    end
    
  end
  
  
  describe '.identificadores' do
    
    context 'cuando el tipo dado es nulo' do
      
      it 'es un arreglo con los identificadores de todas las series' do
        ids = described_class.identificadores
        ids_serie = described_class::TIPOS.inject([]){ |arr, tipo_serie| arr << tipo_serie.last.values.each.map{ |s| s[:id] } }.flatten
        ids_serie.each do |id|
          expect(ids).to include id
        end
      end
      
    end
    
    
    context 'cuando el tipo dado no es nulo' do
      
      context 'cuando el tipo dado no existe' do
        
        it 'levanta una excepción' do
          tipo = :tipo_inexistente
          expect { described_class.identificadores(tipo) }.to raise_error(ArgumentError, "El tipo no existe (tipo: #{tipo}).")
        end
        
      end
    
      context 'cuando el tipo dado existe' do
      
        it 'es un arreglo con los identificadores de todas las series del tipo dado' do
          tipo = :tipos_de_cambio
          ids = described_class.identificadores(tipo)
          ids_serie = described_class::send(tipo).values.each.map{ |s| s[:id] }
          ids_serie.each do |id|
            expect(ids).to include id
          end
        end
      
      end
      
    end
    
  end
  
  
  describe '.nombre' do
    
    context 'cuando el identificador dado no existe' do
      let!(:id){ "IDINEXISTENTE" }
      
      context 'cuando el tipo dado es nulo' do
        
        it 'levanta una excepción' do
          expect { described_class.nombre(id) }.to raise_error(ArgumentError, "El identificador no existe (identificador: #{id}).")
        end
        
      end
      
      
      context 'cuando el tipo dado no es nulo' do
        
        context 'cuando el tipo dado no existe' do
          
          it 'levanta una excepción' do
            tipo = :tipo_inexistente
            expect { described_class.nombre(id, tipo) }.to raise_error(ArgumentError, "El tipo no existe (tipo: #{tipo}).")
          end
          
        end
        
        
        context 'cuando el tipo dado existe' do
          
          it 'levanta una excepción' do
            tipo = :tipos_de_cambio
            expect { described_class.nombre(id, :tipos_de_cambio) }.to raise_error(ArgumentError, "El identificador (identificador: #{id}) no se encuentra en el tipo de serie dado (tipo: #{tipo}).")
          end
          
        end
        
      end
    end
    
    
    context 'cuando el identificador dado existe' do
      let!(:id){ "SF43718" }
      let!(:nombre){ :dolar_fix }
      
      context 'cuando el tipo dado es nulo' do
        
        it 'es el nombre de la serie correspondiente al identificador' do
          expect(described_class.nombre(id)).to eq nombre
        end
        
      end
      
      
      context 'cuando el tipo dado no es nulo' do
        
        context 'cuando el tipo dado no existe' do
          
          it 'levanta una excepción' do
            tipo = :tipo_inexistente
            expect { described_class.nombre(id, tipo) }.to raise_error(ArgumentError, "El tipo no existe (tipo: #{tipo}).")
          end
          
        end
        
        
        context 'cuando el tipo dado existe' do
          let!(:tipo) { :tipos_de_cambio }
          
          context 'cuando el identificador corresponde al tipo de serie dado' do
            
            it 'es el nombre de la serie correspondiente al identificador' do
              expect(described_class.nombre(id)).to eq nombre
            end
            
          end

          
          context 'cuando el identificador no corresponde al tipo de serie dado' do
            let!(:id){ "SP68257" }
            
            it 'levanta una excepción' do
              expect { described_class.nombre(id, tipo) }.to raise_error(ArgumentError, "El identificador (identificador: #{id}) no se encuentra en el tipo de serie dado (tipo: #{tipo}).")
            end
            
          end
          
        end
        
      end
      
    end
    
  end
  
  
  describe '.nombres' do
    
    context 'cuando el tipo dado es nulo' do
      
      it 'es un arreglo con los nombres de todas las series' do
        nombres = described_class.nombres
        nombres_serie = described_class::TIPOS.inject([]){ |arr, tipo_serie| arr << tipo_serie.last.keys }.flatten
        nombres_serie.each do |nombre|
          expect(nombres).to include nombre
        end
      end
      
    end
    
    
    context 'cuando el tipo dado no es nulo' do
      
      context 'cuando el tipo dado no existe' do
        
        it 'levanta una excepción' do
          tipo = :tipo_inexistente
          expect { described_class.nombres(tipo) }.to raise_error(ArgumentError, "El tipo no existe (tipo: #{tipo}).")
        end
        
      end
    
      context 'cuando el tipo dado existe' do
      
        it 'es un arreglo con los nombres de todas las series del tipo dado' do
          tipo = :tipos_de_cambio
          nombres = described_class.nombres(tipo)
          nombres_serie = described_class::send(tipo.to_sym).keys
          expect(nombres_serie).to be_a Array
          nombres_serie.each do |nombre|
            expect(nombres).to include nombre
          end
        end
      
      end
      
    end
    
  end
  
end