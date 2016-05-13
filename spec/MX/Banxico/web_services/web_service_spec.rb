require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')
require 'webmock/rspec'
require "savon/mock/spec_helper"

describe MX::Banxico::WebServices::WebService, :ws do
  include Savon::SpecHelper
  
  
  before(:context) { WebMock.disable! }
  after(:context) { WebMock.reset! }
  
  
  describe '#realizar_operacion' do
    
    context 'cuando la operación no está soportada por el servicio web' do
      
      it 'lanza una excepción' do
        op = :operacion_inexistente
        expect { subject.realizar_operacion(op) }.to raise_error(ArgumentError, "La operación #{op} no está soportada.")
      end
      
    end
    
    
    context 'cuando el número de intentos es menor a uno (1)' do
      
      it 'lanza una excepción' do
        expect { subject.realizar_operacion(:tipos_de_cambio_banxico, 0) }.to raise_error(ArgumentError, "El número de intentos debe ser mayor o igual a 1.")
      end
      
    end
    
    
    context 'cuando se realiza la operación con éxito' do
      before(:context) { savon.mock! }
      after(:context) { savon.unmock! }
      let!(:operacion) { described_class.operaciones.sample }
      let!(:fixture) { File.read("spec/fixtures/MX/Banxico/web_services/respuestas_correctas/#{operacion}.xml") }
      let!(:peticion){ savon.expects(operacion).returns(fixture) }
      let!(:respuesta) { subject.realizar_operacion(operacion) }
      

      it 'la estructura Respuesta tiene el cuerpo de la respuesta de la operación' do
        expect(respuesta.cuerpo).to be_a String
      end
      
      it 'la estructura Respuesta indica que la operación tuvo éxito' do
        expect(respuesta.exito?).to be_truthy
      end
      
      it 'la estructura Respuesta no tiene errores' do
        expect(respuesta.errores?).to be_falsey
      end
      
      it 'errores es nulo en la estructura Respuesta' do
        expect(respuesta.errores).to be_nil
      end
      
    end
    
    
    context 'cuando no se realiza la operación con éxito' do
      before(:context) { WebMock.enable! }
      after(:context) { WebMock.disable! }
      
      context 'cuando se agota el número de intentos' do
        let!(:respuesta) { subject.realizar_operacion(described_class.operaciones.sample, 1) }
      

        it 'la estructura Respuesta no tiene el cuerpo de la respuesta de la operación' do
          expect(respuesta.cuerpo).to be_nil
        end
      
        it 'la estructura Respuesta indica que la operación no tuvo éxito' do
          expect(respuesta.exito?).to be_falsey
        end
      
        it 'la estructura Respuesta tiene errores' do
          expect(respuesta.errores?).to be_truthy
        end
      
        it 'la estructura Respuesta tiene los errores de la operación' do
          expect(respuesta.errores).to be_a String
          expect(respuesta.errores).to match /Número de intentos agotados/
        end
        
      end
      
    end
    
  end
  
  
  describe '.operaciones' do
    
    it 'es un arreglo con las operaciones permitidas por el servicio web' do
      expect(described_class.operaciones).to eq described_class::OPERACIONES_WS
    end
    
    it 'tiene las mismas operaciones que el servicio web' do
      WebMock.disable!
      subject.client.operations.each do |op|
        expect(described_class.operaciones).to include op
      end
    end
  end
  
end