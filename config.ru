require 'ruby-debug'
require 'rubygems'
require 'rack'
require 'rack/openid'


use Rack::ShowExceptions

class OpenIDer
  
  attr_accessor :env, :options
  
  def initialize(app, options ={})
    @app = app
    @options = options
    
    # fail_path
    # success_path || return_to
  end
  
  def call(env)
    @env = env
    if allowed?
      # pass through
      @app.call(env)
    else
      # break chain, start open_id_login
      open_id_login
    end
  end
  
  def open_id_login
    if resp = env["rack.openid.response"]
      case resp.status
      when :success
        #... save id and forward to ...
        self.verified_identity = resp.identity_url
        forward_to(protected_path)
      when :failure
        if login_path
          forward_to(login_path)
        else
          
        end
      end
    else
      self.protected_path = env['REQUEST_PATH']
      puts identitifier_to_verify
      [401, {"WWW-Authenticate" => "OpenID identifier=\"#{identitifier_to_verify}\""}, []]
    end
    
  end
  
  def forward_to(url)
    [302, {'Location' => url}, ["Forwarding to #{url}"]]
  end
  
  def login_page
    
  end
  
  def allowed?
    allowed_identifiers.include? verified_identity
  end
  
  def allowed_identifiers
    options[:allowed_identifiers]
  end
  
  def login_path
    options[:login_path]
  end
  
  def identitifier_to_verify
    env["rack.request.query_hash"]["open_id_identifier"]
  end
  
  def verified_identity=(url)
    session['verified_identity'] = url
  end
  
  def verified_identity
    session['verified_identity']
  end
  
  def session
    env['rack.session']
  end
  
  def protected_path=(path)
    session['return_to'] = path
  end
  
  def protected_path
    session['return_to'] || default_return_to
  end
  
  def default_return_to
    options['default_return_to'] || '/'
  end
  
  def success
    [200,{"Content-Type" => 'text/html'},'great success']
  end
  
  def fail
    [200,{"Content-Type" => 'text/html'},'fail!']
  end
  
  def openid
    [200,{"Content-Type" => 'text/html'},'openid']
  end
  
end


class HelloWorld
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["Made it through!"]]
  end
end


use Rack::Session::Cookie
use Rack::OpenID
use OpenIDer, :allowed_identifiers => ['http://samsm.com/']
run HelloWorld.new
