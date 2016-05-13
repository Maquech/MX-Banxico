begin
  require "MX/Banxico/version"
  require 'bundler/gem_tasks'
  require 'rspec/core/rake_task'
  require 'yard'
  YARD::Rake::YardocTask.new
  
  RSpec::Core::RakeTask.new(:spec, :tag) do |t, task_args|
    t.rspec_opts = ["--tag #{task_args[:tag]}", "--format", "--color"]
  end
  
  task default: :spec
  task test: :spec
  

  task :build do  
    system "gem build MX-Banxico.gemspec"
  end

  task :release => :build do  
    system "gem push mx-banxico-#{MX::Banxico::VERSION}"
  end  
  
rescue LoadError
end

