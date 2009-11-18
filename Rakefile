# Rakefile
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('easy-rack-open-id', '0.0.2') do |p|
  p.summary        = "Super easy OpenID protection for Rack."
  p.description    = "You supply OpenIDs, this keeps anyone but people with access to those ids from getting through."
  p.url            = "http://samsm.com/"
  p.author         = "Sam Schenkman-Moore"
  p.email          = "samsm@samsm.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.runtime_dependencies = ['rack-openid']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
