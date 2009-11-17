class EasyRackOpenID
  
  attr_accessor :env, :options
  
  def initialize(app, options ={})
    @app = app
    @options = options
  end
  
  def call(env)
    @env = env
    if logout_path == path
      logout_result = logout
      return logout_result if logout_result
    end
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
      if identitifier_to_verify
        self.protected_path = path
        [401, {"WWW-Authenticate" => "OpenID identifier=\"#{identitifier_to_verify}\""}, []]
      else
        present_login_options
      end
    end
    
  end
  
  def path
    env['REQUEST_PATH']
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
    if allowed_identifiers
      allowed_identifiers.include? verified_identity
    else
      verified_identity
    end
  end
  
  def allowed_identifiers
    options[:allowed_identifiers]
  end
  
  def logout_path
    options[:logout_path] || '/logout'
  end
  
  def logout
    self.verified_identity = nil
    if after_logout_path
      forward_to(after_logout_path)
    end
  end
  
  def after_logout_path
    options[:after_logout_path]
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
  
  def ok(text)
    [200,{"Content-Type" => 'text/html', 'Content-Length'=> text.length},text]
  end

end
