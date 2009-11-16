require 'rubygems'
require 'rack'
gem 'rack-openid'
require 'rack/openid'



use Rack::ShowExceptions



MyApp = lambda { |env|
  if resp = env["rack.openid.response"]
    case resp.status
    when :success
      ...
    when :failure
      ...
  else
    [401, {"WWW-Authenticate" => 'OpenID identity="http://example.com/"'}, []]
  end
}

use Rack::OpenID
run MyApp
