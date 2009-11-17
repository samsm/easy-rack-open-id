require 'ruby-debug'
require 'rubygems'
require 'rack'
require 'rack/openid'
require 'lib/openider'

use Rack::ShowExceptions



class HelloWorld
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["Made it through!"]]
  end
end


use Rack::Session::Cookie
use Rack::OpenID
use OpenIDer, :allowed_identifiers => ['http://samsm.com/']
run HelloWorld.new
