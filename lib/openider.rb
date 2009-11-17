class OpenIDer
  
  attr_accessor :env, :options
  
  def initialize(app, options ={})
    @app = app
    @options = options
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
        present_login_options
      end
    else
      puts 'verify'
      if identitifier_to_verify
        self.protected_path = env['REQUEST_PATH']
        [401, {"WWW-Authenticate" => "OpenID identifier=\"#{identitifier_to_verify}\""}, []]
      else
        present_login_options
      end
    end
    
  end
  
  def present_login_options
    if login_path
      forward_to(login_path)
    else
      dir = File.dirname(__FILE__)
      form = IO.read(dir + '/generic_openid_form.html.erb')
      ok(form)
    end
  end
  
  def forward_to(url)
    [302, {'Location' => url}, ["Forwarding to #{url}"]]
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
    env["rack.request.query_hash"]["openid_identifier"]
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
    options[:default_return_to] || '/'
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
  
  def ok(text)
    [200,{"Content-Type" => 'text/html', 'Content-Length'=> text.length},text]
  end

end
