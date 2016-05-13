require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')
require 'webmock/rspec'

describe MX::Banxico::Historico::TipoDeCambio, :tipo_de_cambio_historico do
  let!(:post_url){ "#{described_class::URL}#{described_class::POST_PATH}" }
  
  before(:context) { WebMock.disable! }
  after(:context) { WebMock.reset! }
  
  
  describe '#de_serie' do
    
    context 'cuando no existe la serie' do
      let!(:serie){ :serie_inexistente }
      let!(:historico_tdc){ described_class.new }
      let!(:arr){ historico_tdc.de_serie(serie) }
      
      it 'es nil' do
        historico_tdc = described_class.new
        expect(historico_tdc.de_serie(:serie_inexistente)).to be_nil
      end
      
      
      describe '#errores' do
        
        it 'es la descripción del error' do
          expect(historico_tdc.errores).to eq "Error: La serie no existe (serie: #{serie})."
        end
        
      end
      
      
      describe '#errores?' do
        
        it 'es true' do
          expect(historico_tdc.errores?).to be_truthy
        end
        
      end

    end
    
    
    context 'cuando la petición tuvo éxito' do
      
      context 'cuando no es una respuesta satisfactoria' do
        before(:context) { WebMock.enable! }
        let!(:serie){ :dolar_fix }
        
        [404, 500].each do |codigo|
          
          context "cuando no se encontró la página (#{codigo})" do
            let!(:req){ stub_request(:any, post_url).to_return(status: codigo) }
            let(:historico_tdc){ described_class.new }
            let!(:arr){ historico_tdc.de_serie(serie) }

            it 'es nil' do
              expect(arr).to be_nil
            end
          
          
            describe '#errores' do
              
              it 'es la descripción del error' do
                expect(historico_tdc.errores).to eq "Error: código de error #{codigo}."
              end
              
            end
            
            
            describe '#errores?' do
              
              it 'es true' do
                expect(historico_tdc.errores?).to be_truthy
              end
              
            end
            
          end
        
        end
        
      end
      
      
      context 'cuando se obtuvo una respuesta satisfactoria (200 - OK)' do
        let!(:serie){ :dolar_fix }
        let!(:año){ 2015 }
        
        context 'cuando la respuesta tiene series' do
          let(:historico_tdc){ described_class.new }
          
          
          context 'cuando se realiza una conexión al servicio' do
            before(:context) { WebMock.disable! }
            let!(:arr){ historico_tdc.de_serie(serie, año, año) }
          
            it 'es un arreglo de MX::Banxico::TipoDeCambio' do
              expect(arr).to be_a Array
              arr.each do |tdc|
                expect(tdc).to be_a MX::Banxico::TipoDeCambio
                expect(tdc.moneda).to eq serie
              end
            end
          
            it 'el arreglo tiene un elemento por cada día el año' do
              expect(arr.size).to eq dias_tipos_de_cambio_2015(serie)
            end
            
            
            describe '#errores' do
        
              it 'es la descripción del error' do
                expect(historico_tdc.errores).to be_nil
              end
        
            end
      
      
            describe '#errores?' do
        
              it 'es true' do
                expect(historico_tdc.errores?).to be_falsey
              end
        
            end
            
          end
          
          
          context 'cuando se usa un stub de la conexión' do
            before(:context) { WebMock.enable! }
            let!(:cuerpo_ok){ File.read("spec/fixtures/MX/Banxico/historico/tipo_de_cambio/dolar_fix/respuesta_correcta.xml") }
            let!(:req){ stub_request(:any, post_url).to_return(status: 200, body: cuerpo_ok) }
            let!(:arr){ historico_tdc.de_serie(serie, año, año) }
          
            it 'es un arreglo de MX::Banxico::TipoDeCambio' do
              expect(arr).to be_a Array
              arr.each do |tdc|
                expect(tdc).to be_a MX::Banxico::TipoDeCambio
                expect(tdc.moneda).to eq serie
              end
            end
          
            it 'el arreglo tiene un elemento por cada día el año' do
              expect(arr.size).to eq dias_tipos_de_cambio_2015(serie)
            end
            
            
            describe '#errores' do
        
              it 'es la descripción del error' do
                expect(historico_tdc.errores).to be_nil
              end
        
            end
      
      
            describe '#errores?' do
        
              it 'es true' do
                expect(historico_tdc.errores?).to be_falsey
              end
        
            end
            
          end
          
        end
        
        
        context 'cuando la respuesta no tiene serie' do
          before(:context) { WebMock.enable! }
          let!(:cuerpo_sin_series){ File.read("spec/fixtures/MX/Banxico/historico/tipo_de_cambio/dolar_fix/sin_serie.xml") }
          let!(:req){ stub_request(:any, post_url).to_return(status: 200, body: cuerpo_sin_series) }
          let!(:historico_tdc){ described_class.new }
          let!(:arr){ historico_tdc.de_serie(serie, año, año) }
          
          it 'es nil' do
            expect(arr).to be_nil
          end
            
            
          describe '#errores' do
            
            it 'es la descripción del error' do
              expect(historico_tdc.errores).to eq "Error: No se encontró información de la serie #{serie} dentro de la respuesta de la petición."
            end
      
          end
          
          
          describe '#errores?' do
            
            it 'es true' do
              expect(historico_tdc.errores?).to be_truthy
            end
            
          end
          
        end
        
        
        context 'cuando la respuesta tiene series sin tipos de cambio' do
          before(:context) { WebMock.enable! }
          let!(:cuerpo_sin_tdc){ File.read("spec/fixtures/MX/Banxico/historico/tipo_de_cambio/dolar_fix/serie_sin_valores.xml") }
          let!(:req){ stub_request(:any, post_url).to_return(status: 200, body: cuerpo_sin_tdc) }
          let!(:historico_tdc){ described_class.new }
          let!(:arr){ historico_tdc.de_serie(serie, año, año) }
          
          it 'es nil' do
            expect(arr).to be_nil
          end
            
            
          describe '#errores' do
      
            it 'es la descripción del error' do
              expect(historico_tdc.errores).to eq "Error: No se encontró información de la serie #{serie} dentro de la respuesta de la petición."
            end
            
          end
          
          
          describe '#errores?' do
            
            it 'es true' do
              expect(historico_tdc.errores?).to be_truthy
            end
            
          end
          
        end
        
        
        context 'cuando la respuesta no tiene la estructura esperada' do
          before(:context) { WebMock.enable! }
          let!(:cuerpo){ File.read("spec/fixtures/MX/Banxico/historico/respuestas_incorrectas/mal_formado.xml") } 
          let!(:req){ stub_request(:any, post_url).to_return(status: 200, body: cuerpo) }
          let!(:historico_tdc){ described_class.new }
          let!(:arr){ historico_tdc.de_serie(:dolar_fix) }
          
          it 'es nil' do
            expect(arr).to be_nil
          end
          
          
          describe '#errores' do
            
            it 'tiene el mensaje de error' do
              expect(historico_tdc.errores).to eq "Error: La respuesta de la petición no tiene el formato correcto."
            end
            
          end
          
          
          describe '#errores?' do
            
            it 'es true' do
              expect(historico_tdc.errores?).to be_truthy
            end
            
          end
          
        end
        
      end
      
    end

  end
  
  
  describe '#completo' do
    
    context 'cuando la petición tuvo éxito' do
      
      context 'cuando no es una respuesta satisfactoria' do
        before(:context) { WebMock.enable! }
        
        [404, 500].each do |codigo|
          
          context "cuando no se encontró la página (#{codigo})" do
            let!(:req){ stub_request(:any, post_url).to_return(status: codigo) }
            let(:historico_tdc){ described_class.new }
            let!(:arr){ historico_tdc.completo }

            it 'es nil' do
              expect(arr).to be_nil
            end
          
          
            describe '#errores' do
              
              it 'es la descripción del error' do
                expect(historico_tdc.errores).to eq "Error: código de error #{codigo}."
              end
              
            end
            
            
            describe '#errores?' do
              
              it 'es true' do
                expect(historico_tdc.errores?).to be_truthy
              end
              
            end
            
          end
        
        end
        
      end
      
      
      context 'cuando se obtuvo una respuesta satisfactoria (200 - OK)' do
        let!(:año){ 2015 }
        
        context 'cuando la respuesta tiene series' do
          let!(:nombres_series){ MX::Banxico::Series.nombres(:tipos_de_cambio) }
          let(:historico_tdc){ described_class.new }
          
          
          context 'cuando se realiza una conexión al servicio' do
            before(:context) { WebMock.disable! }
            let!(:arr){ historico_tdc.completo(año, año) }
          
            it 'es un arreglo de MX::Banxico::TipoDeCambio' do
              expect(arr).to be_a Array
              nombres_series.each do |serie|
                arr.select{|t| t.moneda == serie }.each do |tdc|
                  expect(tdc).to be_a MX::Banxico::TipoDeCambio
                end
              end
            end
          
            it 'el arreglo tiene un elemento por cada día el año' do
              nombres_series.each do |serie|
                expect(arr.select{|t| t.moneda == serie }.size).to eq dias_tipos_de_cambio_2015(serie)
              end
            end
            
            
            describe '#errores' do
        
              it 'es la descripción del error' do
                expect(historico_tdc.errores).to be_nil
              end
        
            end
      
      
            describe '#errores?' do
        
              it 'es true' do
                expect(historico_tdc.errores?).to be_falsey
              end
        
            end
            
          end
          
          
          context 'cuando se usa un stub de la conexión' do
            before(:context) { WebMock.enable! }
            let!(:cuerpo_ok){ File.read("spec/fixtures/MX/Banxico/historico/respuestas_correctas/tipo_de_cambio.xml") }
            let!(:req){ stub_request(:any, post_url).to_return(status: 200, body: cuerpo_ok) }
            let!(:arr){ historico_tdc.completo(año, año) }
          
            it 'es un arreglo de MX::Banxico::TipoDeCambio' do
              expect(arr).to be_a Array
              nombres_series.each do |serie|
                arr.select{|t| t.moneda == serie }.each do |tdc|
                  expect(tdc).to be_a MX::Banxico::TipoDeCambio
                end
              end
            end
          
            it 'el arreglo tiene un elemento por cada día el año' do
              nombres_series.each do |serie|
                expect(arr.select{|t| t.moneda == serie }.size).to eq dias_tipos_de_cambio_2015(serie)
              end
            end
            
            
            describe '#errores' do
        
              it 'es la descripción del error' do
                expect(historico_tdc.errores).to be_nil
              end
        
            end
      
      
            describe '#errores?' do
        
              it 'es true' do
                expect(historico_tdc.errores?).to be_falsey
              end
        
            end
            
          end
          
        end
        
        
        context 'cuando la respuesta no tiene series' do
          before(:context) { WebMock.enable! }
          let!(:cuerpo_sin_series){ File.read("spec/fixtures/MX/Banxico/historico/respuestas_incorrectas/sin_series.xml") }
          let!(:req){ stub_request(:any, post_url).to_return(status: 200, body: cuerpo_sin_series) }
          let!(:historico_tdc){ described_class.new }
          let!(:arr){ historico_tdc.completo(año, año) }

          it 'es nil' do
            expect(arr).to be_nil
          end
            
            
          describe '#errores' do
            
            it 'es la descripción del error' do
              expect(historico_tdc.errores).to eq "Error: No se encontraron series en la respuesta."
            end
            
          end
          
          
          describe '#errores?' do
            
            it 'es true' do
              expect(historico_tdc.errores?).to be_truthy
            end
            
          end
          
        end
        
        
        context 'cuando la respuesta tiene series sin tipos de cambio' do
          before(:context) { WebMock.enable! }
          let!(:cuerpo_sin_tdc){ File.read("spec/fixtures/MX/Banxico/historico/respuestas_incorrectas/serie_sin_valores.xml") } 
          let!(:req){ stub_request(:any, post_url).to_return(status: 200, body: cuerpo_sin_tdc) }
          let!(:historico_tdc){ described_class.new }
          let!(:arr){ historico_tdc.completo(año, año) }
          
          it 'es nil' do
            expect(arr).to be_nil
          end
            
            
          describe '#errores' do
            
            it 'es la descripción del error' do
              expect(historico_tdc.errores).to eq "Error: No se encontraron series en la respuesta."
            end
            
          end
          
          
          describe '#errores?' do
            
            it 'es true' do
              expect(historico_tdc.errores?).to be_truthy
            end
            
          end
          
        end
        
        
        context 'cuando la respuesta no tiene la estructura esperada' do
          before(:context) { WebMock.enable! }
          let!(:cuerpo){ File.read("spec/fixtures/MX/Banxico/historico/respuestas_incorrectas/mal_formado.xml") } 
          let!(:req){ stub_request(:any, post_url).to_return(status: 200, body: cuerpo) }
          let!(:historico_tdc){ described_class.new }
          let!(:arr){ historico_tdc.completo }
          
          it 'es nil' do
            expect(arr).to be_nil
          end
          
          
          describe '#errores' do
            
            it 'tiene el mensaje de error' do
              expect(historico_tdc.errores).to eq "Error: La respuesta de la petición no tiene el formato correcto."
            end
            
          end
          
          
          describe '#errores?' do
            
            it 'es true' do
              expect(historico_tdc.errores?).to be_truthy
            end
            
          end
          
        end
        
      end
      
    end
    
  end
  
  
  
  # Cuenta manual :'(
  def dias_tipos_de_cambio_2015(serie)
    case serie
    when :dolar_canadiense
      241
    when :dolar_liquidacion
      365
    else
      251
    end
  end
  
  
end