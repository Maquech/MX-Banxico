require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')
require 'webmock/rspec'
require "savon/mock/spec_helper"

describe MX::Banxico::WebServices::TipoDeCambio, :ws_tipo_de_cambio do
  include Savon::SpecHelper
  
  
  before(:context) { WebMock.disable! }
  after(:context) { WebMock.reset! }
  
  
  describe '#obtener' do
    
    context 'cuando el tipo de cambio no está soportado' do
      
      it 'lanza una excepción' do
        tipo = :tipo_de_cambio_inexistente
        expect { subject.obtener(tipo) }.to raise_error(ArgumentError, "El tipo de cambio no está soportado (#{tipo}).")
      end
      
    end
    
    
    context 'cuando la respuesta es satisfactoria' do
      before(:context) { savon.mock! }
      after(:context) { savon.unmock! }
      let!(:tipo) { :dolar_fix }
      let!(:fixture) { File.read("spec/fixtures/MX/Banxico/web_services/tipo_de_cambio/#{tipo}/respuesta_correcta.xml") }
      let!(:peticion){ savon.expects(:tipos_de_cambio_banxico).returns(fixture) }
      let!(:tipo_de_cambio){ subject.obtener(tipo) }
      
      
      it 'regresa una estructura MX::Banxico::TipoDeCambio' do
        expect(tipo_de_cambio).to be_a MX::Banxico::TipoDeCambio
      end
      
      it 'el importe es un número flotante' do
        expect(tipo_de_cambio.valor_en_mxn).to be_a Float
      end
      
      it 'la fecha es tipo Date' do
        expect(tipo_de_cambio.fecha).to be_a Date
      end
      
      it 'la fecha es igual o menor al día de hoy' do
        expect(tipo_de_cambio.fecha).to be <= Date.today
      end
      
    end
    
    
    context 'cuando la respuesta no es satisfactoria' do
      before(:context) { WebMock.enable! }
      after(:context) { WebMock.disable! }
      let!(:tipo){ described_class::TIPOS_DE_CAMBIO.sample }
      let!(:error_tipo_de_cambio){ subject.obtener(tipo) }
      
      
      it 'regresa una cadena con el error' do
        expect(error_tipo_de_cambio).to be_a String
      end
      
      it 'regresa un error de número de intentos agotados' do
        expect(error_tipo_de_cambio).to match /Número de intentos agotados/
      end
      
    end
    
    
    context 'cuando no es posible obtener el nodo con el tipo de cambio de la respuesta' do
      before(:context) { savon.mock! }
      after(:context) { savon.unmock! }
      let!(:tipo) { :dolar_fix }
      let!(:fixture) { File.read("spec/fixtures/MX/Banxico/web_services/tipo_de_cambio/#{tipo}/error_nodo_obs.xml") }
      let!(:peticion){ savon.expects(:tipos_de_cambio_banxico).returns(fixture) }
      let!(:error_tipo_de_cambio){ subject.obtener(tipo) }
      
      
      it 'regresa una cadena con el error' do
        expect(error_tipo_de_cambio).to be_a String
      end
      
      it 'regresa un error sobre la extracción del nodo con el tipo de cambio' do
        expect(error_tipo_de_cambio).to match /^No fue posible extraer los valores del XML del nodo bm:Obs/
      end
      
    end
    
    
    context 'cuando hubo un error al recuperar la fecha del tipo de cambio de la respuesta' do
      before(:context) { savon.mock! }
      after(:context) { savon.unmock! }
      let!(:tipo) { :dolar_fix }
      let!(:fixture) { File.read("spec/fixtures/MX/Banxico/web_services/tipo_de_cambio/#{tipo}/error_fecha_tipo_de_cambio.xml") }
      let!(:peticion){ savon.expects(:tipos_de_cambio_banxico).returns(fixture) }
      let!(:error_tipo_de_cambio){ subject.obtener(tipo) }
      
      
      it 'regresa una cadena con el error' do
        expect(error_tipo_de_cambio).to be_a String
      end
      
      it 'regresa un error sobre la extracción del nodo con el tipo de cambio' do
        expect(error_tipo_de_cambio).to eq "Error al crear el tipo de cambio a partir del nodo bm:Obs. " +
          "Error: fecha debe ser una cadena (String) en formato ISO-8601 o un objeto de tipo fecha (Date)."
      end
      
    end
    
    
    context 'cuando hubo un error al recuperar el valor del tipo de cambio de la respuesta' do
      before(:context) { savon.mock! }
      after(:context) { savon.unmock! }
      let!(:tipo) { :dolar_fix }
      let!(:fixture) { File.read("spec/fixtures/MX/Banxico/web_services/tipo_de_cambio/#{tipo}/error_valor_tipo_de_cambio.xml") }
      let!(:peticion){ savon.expects(:tipos_de_cambio_banxico).returns(fixture) }
      let!(:error_tipo_de_cambio){ subject.obtener(tipo) }
      
      
      it 'regresa una cadena con el error' do
        expect(error_tipo_de_cambio).to be_a String
      end
      
      it 'regresa un error sobre la extracción del nodo con el tipo de cambio' do
        expect(error_tipo_de_cambio).to eq "Error al crear el tipo de cambio a partir del nodo bm:Obs. " +
          "Error: valor_en_mxn debe ser una cadena con un número decimal o un objeto de tipo (Float)."
      end
      
    end
    
  end
  
  
  describe 'dependencia entre los tipos de cambio definidos en MX::Banxico::Series y la clase descrita' do
    let!(:tipos_en_series){ MX::Banxico::Series.tipos_de_cambio.keys }
    
    it 'los tipos de cambio en TIPOS_DE_CAMBIO se encuentran en MX::Banxico::Series.tipos_de_cambio.keys' do
      described_class::TIPOS_DE_CAMBIO.each do |tipo|
        expect(tipos_en_series).to include tipo
      end
    end
    
    it 'los tipos de cambio en MX::Banxico::Series.tipos_de_cambio.keys se encuentran en TIPOS_DE_CAMBIO' do
      tipos_en_series.each do |tipo|
        expect(described_class::TIPOS_DE_CAMBIO).to include tipo
      end
    end
    
  end
 
end