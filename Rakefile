# Rakefile
require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "easy-rack-open-id"
    gem.summary = "Super easy OpenID protection for Rack."
    gem.description = "You supply OpenIDs, this keeps anyone but people with access to those ids from getting through. You don't even have to make a form. :)"
    gem.email = "samsm@samsm.com"
    gem.homepage = "http://github.com/samsm/Easy-Rack-OpenID"
    gem.authors = ["Sam Schenkman-Moore"]
    gem.add_development_dependency "yard", ">= 0"
    gem.add_runtime_dependency 'rack-openid'
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
