# MX::Banxico


[![Gem Version](https://badge.fury.io/rb/MX-Banxico.png)](https://badge.fury.io/rb/MX-Banxico) [![Build Status](https://travis-ci.org/Maquech/MX-Banxico.svg?branch=master)](https://travis-ci.org/Maquech/MX-Banxico) [![Code Climate](https://codeclimate.com/github/Maquech/MX-Banxico/badges/gpa.svg)](https://codeclimate.com/github/Maquech/MX-Banxico) [![Test Coverage](https://codeclimate.com/github/Maquech/MX-Banxico/badges/coverage.svg)](https://codeclimate.com/github/Maquech/MX-Banxico/coverage)



## Why and what for / Por qué y para qué

This gem was conceived as an aid in the automation of information extraction from the web site and web services provided by
the [Bank of Mexico](http://www.banxico.org.mx).


This project is not endorsed in any way by the Mexican government. It's an effort to contribute to the preservation of mental
health of the developers who have to deal with this things :)


---

Esta gema se concibió como una ayuda para la automatización de extracción de información de la página y servicios web que provee
el [Banco de México](http://www.banxico.org.mx).


Este proyecto no está patrocinado de ninguna forma por el gobierno mexicano. Es un esfuerzo para contribuir a la sanidad mental de los programadores que tenemos que lidiar con estas cosas :)


## Installation / Instalación

Add this line to your application's Gemfile:

```ruby
gem 'mx-banxico'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mx-banxico

---

Agrega esta línea al archivo Gemfile de tu aplicación:

```ruby
gem 'mx-banxico'
```

Luego ejecuta:

    $ bundle

O instálalo tu mismo usando:

    $ gem install mx-banxico


## Dependencies / Dependencias

The only dependencies are:

  * [Nokogiri](http://http://www.nokogiri.org/) for XML processing.
  * [Savon](http://savonrb.com) for web services exploitation.
  * [HTTParty](https://github.com/jnunemaker/httparty/tree/master/lib/httparty) for making a request to the Bank of Mexico's web site and download information.

---

Las únicas dependencias son:

  * [Nokogiri](http://http://www.nokogiri.org/) que es una gema (y una joya) para procesar XML.
  * [Savon](http://savonrb.com) para explotar los servicios web.
  * [HTTParty](https://github.com/jnunemaker/httparty/tree/master/lib/httparty) para hacer una petición al sitio web y descargar
    información de ahí.



## Usage / Uso

El Banco de México (también conocido como Banxico) maneja información de UDIS (Unidades de inversión), tipo de cambio, tasas de interés y reservas internacionales en uno de sus [servicios web] (http://www.banxico.org.mx/DgieWSWeb/DgieWS?WSDL). También, en su sitio web, tienen una [herramienta](http://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?accion=consultarCuadro&idCuadro=CF102&sector=6&locale=es) para consultar la información histórica de diversos indicadores (o series como ellos les llaman).

Ahora, la biblioteca (sí: _library -> biblioteca_, _bookstore -> librería_) está dividida en tres partes, cada una separada por un espacio de nombres (_namespace_) para poder distinguir los elementos con los que se está trabajando: {MX::Banxico}, {MX::Banxico::Historico} y {MX::Banxico::WebServices}.

#### Ejemplos:

* Para trabajar con el tipo de cambio histórico, se utiliza una instancia de {MX::Banxico::Historico::TipoDeCambio}.
* Si deseas obtener el tipo de cambio al día de hoy, usa una instancia de {MX::Banxico::WebServices::TipoDeCambio}.


En la clase {MX::Banxico::Series} encontrarás métodos para listar las series con las que trabaja la biblioteca. Básicamente es un contenedor de la información de las series (o indicadores) que tiene Banxico. La información ahí contenida se extrajo principalmente del servicio web, aunque la herramienta de consulta web del Banco también la maneja de la misma forma (se agradece consistencia).

Tanto los servicios web como la página, devuelven XML. Para facilitar las cosas, todos los métodos de clases o instancias en {MX::Banxico::Historico::TipoDeCambio} o {MX::Banxico::WebServices::TipoDeCambio} devuelven arreglos de objetos (u objetos) del tipo {MX::Banxico::TipoDeCambio}. **¿Ves el patrón?** La idea es que si trabajarás con UDIS, uses {MX::Banxico::Historico::UDIS}, {MX::Banxico::WebServices::UDIS} y {MX::Banxico::UDIS}.

Por el momento, sólo están las clases para trabajar con el tipo de cambio :'( pero siempre puedes contribuir a esta biblioteca y hacer a más gente feliz :)


## Docs

Check the [online documentation](http://http://www.rubydoc.info/gems/MX-Banxico/1.0) or generate it using YARD with:

    $ bundle exec yard server --port 8828 --reload

Also, check the [references](REFERENCIAS.md).

---

Consulta la [documentación en línea](http://http://www.rubydoc.info/gems/MX-Banxico/1.0) o genera la documentación con YARD: 

    $ bundle exec yard server --port 8828 --reload

También revisa las [referencias](REFERENCIAS.md).


## Contributing / Contribuir

1. Fork it ( https://github.com/Maquech/MX-Banxico/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create your specs (100% coverage please!) and add code or make changes (TDD, right?)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

You can also submit technical observations on the algorithms here implemented alongside with references to official documentation that supports it.

---

Puedes contribuir mandándonos tus observaciones sobre la implementación de los algoritmos aquí implementados o referencias a documentos oficiales que las respalde.

Ahora, diviérte con esta traducción (si sabes el término correcto en español, háznoslo saber por favor):

1. Crea tu copia del repositorio ( https://github.com/Maquech/MX-Banxico/fork )
2. Crea tu rama con la funcionalidad propuesta (`git checkout -b mi-nueva-funcionalidad-shubiduby`)
3. Crea tus pruebas (specs que tengan una covertura del 100% porfa) y realiza cambios o agrega código (estás haciendo TDD, ¿cierto?)
4. Compromete tus cambios (`git commit -am 'Nueva funcionalidad shubiduby'`)
5. Empuja la rama a tu repositorio (`git push origin mi-nueva-funcionalidad-shubiduby`)
6. Crea una nueva petición de jalada|tirada|extracción|acarreo



