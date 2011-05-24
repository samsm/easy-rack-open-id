# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "easy-rack-openid/version"

Gem::Specification.new do |s|
  s.name        = "easy-rack-openid"
  s.version     = Easy::Rack::Openid::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sam Schenkman-Moore"]
  s.email       = ["samsm@samsm.com"]
  s.homepage    = "http://github.com/samsm/easy-rack-openid"
  s.summary     = %q{Super easy OpenID protection for Rack.}
  s.description = %q{You supply OpenIDs, this keeps anyone but people with access to those ids from getting through. You don't even have to make a form. :)}

  s.rubyforge_project = "easy-rack-openid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rack-openid', ['~> 1.3']
end
