require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe MX::Banxico::TipoDeCambio, :tdc do
  let!(:tipo_de_cambio){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
  
  
  describe '.new' do
    
    describe 'parámetro moneda' do
      
      context 'cuando el parámetro es del tipo correcto' do
        
        context 'cuando es un símbolo' do
          let!(:tdc) { described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          
          it 'es una instancia de la clase' do
            expect(tdc).to be_a described_class
          end
          
          
          describe '.moneda' do
            
            it 'es un símbolo' do
              expect(tdc.moneda).to be_a Symbol
            end
            
          end
          
        end
        
        
        context 'cuando es una cadena' do
          let!(:tdc) { described_class.new("dolar_fix", Date.new(2016,1,1), 18.0001) }
          
          it 'es una instancia de la clase' do
            expect(tdc).to be_a described_class
          end
          
          
          describe '.moneda' do
            
            it 'es un símbolo' do
              expect(tdc.moneda).to be_a Symbol
            end
            
          end
          
        end
        
      end
      
      
      context 'cuando el parámetro NO es del tipo correcto' do
        
        it 'lanza una excepción' do
          expect{
            described_class.new(nil, Date.new(2016,1,1), 18.0001)
          }.to raise_error(ArgumentError, "moneda debe ser una cadena (String) o un objeto tipo símbolo (Symbol).")
        end
        
      end
      
    end
    
    
    describe 'parámetro fecha' do
      
      context 'cuando el parámetro fecha es correcto' do
      
        context 'cuando la fecha es una cadena en formato IS0-8601' do
          let!(:tdc){ described_class.new(:dolar_fix, "2016-01-01", 18.0001) }
          
          it 'es una instancia de la clase' do
            expect(tdc).to be_a described_class
          end
          
          
          describe '.fecha' do
            
            it 'es de tipo fecha (Date)' do
              expect(tdc.fecha).to be_a Date
            end
            
          end
      
        end
        
        
        context 'cuando la fecha es un objeto fecha (Date)' do
          let!(:tdc){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          
          it 'es una instancia de la clase' do
            expect(tdc).to be_a described_class
          end
          
          
          describe '.fecha' do
            
            it 'es de tipo fecha (Date)' do
              expect(tdc.fecha).to be_a Date
            end
            
          end
      
        end
      
      end
    
    
      context 'cuando el parámetro fecha NO es correcto' do
      
        context 'cuando la fecha es una cadena SIN formato IS0-8601' do
      
          it 'lanza una excepción' do
            expect{
              described_class.new(:dolar_fix, "abc", 18.0001)
            }.to raise_error(ArgumentError, "fecha debe ser una cadena (String) en formato ISO-8601 o un objeto de tipo fecha (Date).")
          end
      
        end
    
        context 'cuando la fecha NO es un objeto fecha (Date)' do
      
          it 'lanza una excepción' do
            expect{
              described_class.new(:dolar_fix, nil, 18.0001)
            }.to raise_error(ArgumentError, "fecha debe ser una cadena (String) en formato ISO-8601 o un objeto de tipo fecha (Date).")
          end
      
        end
      
      end
      
    end
    
    
    describe 'parámetro valor_en_mxn' do
      
      context 'cuando el parámetro valor_en_mxn es correcto' do
      
        context 'cuando el valor en pesos es una cadena de un número decimal' do
          let!(:tdc){ described_class.new(:dolar_fix, Date.new(2016,1,1), "18.0001") }
          
          it 'es una instancia de la clase' do
            expect(tdc).to be_a described_class
          end
          
          
          describe '.valor_en_mxn' do
            
            it 'es de tipo fecha (Date)' do
              expect(tdc.valor_en_mxn).to be_a Float
            end
            
          end
          
        end
    
        context 'cuando el valor en pesos es un número flotante (Float)' do
          let!(:tdc){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          
          it 'es una instancia de la clase' do
            expect(tdc).to be_a described_class
          end
          
          
          describe '.valor_en_mxn' do
            
            it 'es de tipo fecha (Date)' do
              expect(tdc.valor_en_mxn).to be_a Float
            end
            
          end
          
        end
      
      end
    
    
      context 'cuando el parámetro valor_en_mxn NO es correcto' do
      
        context 'cuando el valor en pesos NO es una cadena de un número decimal' do
      
          it 'lanza una excepción' do
            expect{
              described_class.new(:dolar_fix, Date.new(2016,1,1), "moquito")
            }.to raise_error(ArgumentError, "valor_en_mxn debe ser una cadena con un número decimal o un objeto de tipo (Float).")
          end
      
        end
    
        context 'cuando el valor en pesos no es un número flotante (Float)' do
      
          it 'lanza una excepción' do
            expect{
              described_class.new(:dolar_fix, Date.new(2016,1,1), nil)
            }.to raise_error(ArgumentError, "valor_en_mxn debe ser una cadena con un número decimal o un objeto de tipo (Float).")
          end
      
        end
      
      end
      
    end
    
  end
  
  
  describe '#moneda' do
    
    it 'es de tipo Symbol' do
      expect(tipo_de_cambio.moneda).to be_a Symbol
    end
    
    it 'es :dolar_fix' do
      expect(tipo_de_cambio.moneda).to eq :dolar_fix
    end
    
  end
  
  
  describe '#fecha' do
    
    it 'es de tipo Date' do
      expect(tipo_de_cambio.fecha).to be_a Date
    end
    
    it 'es la fecha 2016-01-01' do
      expect(tipo_de_cambio.fecha).to eq Date.new(2016,1,1)
    end
    
  end
  
  
  describe '#valor_en_mxn' do
    
    it 'es de tipo Date' do
      expect(tipo_de_cambio.valor_en_mxn).to be_a Float
    end
    
    it 'es 18.0001' do
      expect(tipo_de_cambio.valor_en_mxn).to eq 18.0001
    end
    
  end
  
  
  describe '#to_s' do
    
    it 'es la cadena "dolar_fix: $18.0001 MXN al día 2016-01-01"' do
      expect(tipo_de_cambio.to_s).to eq "dolar_fix: $18.0001 MXN al día 2016-01-01"
    end
    
  end
  
  
  describe '#==' do
    
    context 'cuando la cadena de la moneda de x es igual a la cadena de la moneda de y' do
      
      context 'cuando la fecha de x es igual a la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
      
          it 'x es igual a y' do
            expect(x == y).to be_truthy
          end
        end
        
        
        context 'cuando el valor en pesos de x NO es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 19.0001) }
      
          it 'x NO es igual a y' do
            expect(x == y).to be_falsey
          end
        end
        
      end
      
      
      context 'cuando la fecha de x NO es igual a la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
      
          it 'x NO es igual a y' do
            expect(x == y).to be_falsey
          end
        end
        
        
        context 'cuando el valor en pesos de x NO es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 19.0001) }
      
          it 'x NO es igual a y' do
            expect(x == y).to be_falsey
          end
        end
        
      end
      
    end
    
    
    context 'cuando la cadena de la moneda de x NO es igual a la cadena de la moneda de y' do
      
      context 'cuando la fecha de x es igual a la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
      
          it 'x NO es igual a y' do
            expect(x == y).to be_falsey
          end
        end
        
        
        context 'cuando el valor en pesos de x NO es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 19.0001) }
      
          it 'x NO es igual a y' do
            expect(x == y).to be_falsey
          end
        end
        
      end
      
      
      context 'cuando la fecha de x NO es igual a la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
      
          it 'x NO es igual a y' do
            expect(x == y).to be_falsey
          end
        end
        
        
        context 'cuando el valor en pesos de x NO es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 19.0001) }
      
          it 'x NO es igual a y' do
            expect(x == y).to be_falsey
          end
        end
        
      end
      
    end
    
  end
  
  
  describe '#<=>' do
    
    context 'cuando la cadena de la moneda de x es igual a la cadena de la moneda de y' do
      
      context 'cuando la fecha de x es igual a la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
      
          it 'x == y' do
            expect(x <=> y).to eq 0
          end
        end
        
        
        context 'cuando el valor en pesos de x es menor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 19.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
        
        context 'cuando el valor en pesos de x es mayor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 19.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
      end
      
      
      context 'cuando la fecha de x es menor que la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
        
        context 'cuando el valor en pesos de x es menor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 19.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
        
        context 'cuando el valor en pesos de x es mayor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 19.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
      end
      
      
      context 'cuando la fecha de x es mayor que la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
        
        context 'cuando el valor en pesos de x es menor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2015,1,1), 19.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
        
        context 'cuando el valor en pesos de x es mayor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 19.0001) }
          let!(:y){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
      end
      
    end
    
    
    context 'cuando la cadena de la moneda de x es menor que la cadena de la moneda de y' do
      
      context 'cuando la fecha de x es igual a la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
        
        context 'cuando el valor en pesos de x es menor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 19.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
        
        context 'cuando el valor en pesos de x es mayor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 19.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
      end
      
      
      context 'cuando la fecha de x es menor que la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
        
        context 'cuando el valor en pesos de x es menor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 19.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
        
        context 'cuando el valor en pesos de x es mayor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2015,1,1), 19.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
      end
      
      
      context 'cuando la fecha de x es mayor que la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2015,1,1), 18.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
        
        context 'cuando el valor en pesos de x es menor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2015,1,1), 19.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
        
        context 'cuando el valor en pesos de x es mayor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_fix, Date.new(2016,1,1), 19.0001) }
          let!(:y){ described_class.new(:dolar_liquidacion, Date.new(2015,1,1), 18.0001) }
      
          it 'x < y' do
            expect(x <=> y).to eq -1
          end
        end
        
      end
      
    end
    
    
    context 'cuando la cadena de la moneda de x es mayor que la cadena de la moneda de y' do
      
      context 'cuando la fecha de x es igual a la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_canadiense, Date.new(2016,1,1), 18.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
        
        context 'cuando el valor en pesos de x es menor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_canadiense, Date.new(2016,1,1), 19.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
        
        context 'cuando el valor en pesos de x es mayor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 19.0001) }
          let!(:y){ described_class.new(:dolar_canadiense, Date.new(2016,1,1), 18.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
      end
      
      
      context 'cuando la fecha de x es menor que la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_liquidacion, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_canadiense, Date.new(2016,1,1), 18.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
        
        context 'cuando el valor en pesos de x es menor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_liquidacion, Date.new(2015,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_canadiense, Date.new(2016,1,1), 19.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
        
        context 'cuando el valor en pesos de x es mayor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_liquidacion, Date.new(2015,1,1), 19.0001) }
          let!(:y){ described_class.new(:dolar_canadiense, Date.new(2016,1,1), 18.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
      end
      
      
      context 'cuando la fecha de x es mayor que la de y' do
        
        context 'cuando el valor en pesos de x es igual al valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_canadiense, Date.new(2015,1,1), 18.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
        
        context 'cuando el valor en pesos de x es menor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 18.0001) }
          let!(:y){ described_class.new(:dolar_canadiense, Date.new(2015,1,1), 19.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
        
        context 'cuando el valor en pesos de x es mayor que valor en pesos de y' do
          let!(:x){ described_class.new(:dolar_liquidacion, Date.new(2016,1,1), 19.0001) }
          let!(:y){ described_class.new(:dolar_canadiense, Date.new(2015,1,1), 18.0001) }
      
          it 'x > y' do
            expect(x <=> y).to eq 1
          end
        end
        
      end
      
    end
    
  end
  
  
  
end