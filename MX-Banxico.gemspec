lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'MX/Banxico/version'

Gem::Specification.new do |spec|
  spec.name          = "MX-Banxico"
  spec.version       = MX::Banxico::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Pablo Ruiz"]
  spec.email         = ["pjruiz@maquech.com.mx"]
  spec.summary       = %q{Banco de México web services utilities / Utilerías para usar los servicios web del Banco de México (Banxico)}
  spec.description   = %q{Banco de México web services utilities / Utilerías para usar los servicios web del Banco de México (Banxico)}
  spec.homepage      = "https://github.com/Maquech/MX-Banxico"
  spec.license       = "MIT"
  
  spec.required_ruby_version  = '>= 2.0'
  
  spec.add_dependency 'nokogiri', '~> 1.6'
  spec.add_dependency 'httparty', '~> 0.13'
  spec.add_dependency 'savon', '~> 2.11'
  
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.post_install_message   = "¡Viva México!"
  
end
