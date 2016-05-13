source 'https://rubygems.org'

gemspec

group :development, :ci_filter do
  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-rspec', require: false
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-byebug', platform: [:mri_20, :mri_21, :mri_22]
  gem 'pry-nav', platform: [:mri_19, :jruby]
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
end

group :development, :test do
  gem 'bundler'
  gem 'rake'
  gem 'rspec'
end

group :test do
  gem 'codeclimate-test-reporter'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers', require: false
  gem 'webmock', require: false
end

group :doc do
  gem 'yard'
  gem 'redcarpet'
  gem 'github-markup'
end
