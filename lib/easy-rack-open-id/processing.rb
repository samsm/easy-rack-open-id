module EasyRackOpenId
  class Processing

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
      if asset?
        content_type_lookup = {'css' => 'text/css','html'=> 'text/html','js'=>'text/javascript','gif'=>'image/gif','ico' => 'image/vnd.microsoft.icon', 'png'=> 'image/png'}
        ok(IO.read(gem_public_path + path), content_type_lookup[File.extname(path)[1..-1]])
      elsif allowed?
        # pass through
        @app.call(env)
      else
        # break chain, start open_id_login
        open_id_login
      end
    end

    def asset?
      0 == path.index(asset_prefix)
    end

    def asset_prefix
      '/easy-rack-open-id-assets'
    end

    def gem_public_path
      File.dirname(__FILE__) + '/../../public/'
    end

    def open_id_login
      if resp = env["rack.openid.response"]
        case resp.status
        when :success
          # Load in any registration data gathered
          profile_data = {}
          # merge the SReg data and the AX data into a single hash of profile data
          [ OpenID::SReg::Response, OpenID::AX::FetchResponse ].each do |data_response|
            if data_response.from_success_response( resp )
              profile_data.merge! data_response.from_success_response( resp ).data
            end
          end

          profile_data['identifier'] = resp.identity_url
          #... save id and registration and forward to ...
          self.verified_identity = profile_data
          forward_to(protected_path)
        when :failure
          present_login_options
        end
      else
        if identitifier_to_verify && valid_identifier?
          self.protected_path = path
          header_hash =  {:identifier => identitifier_to_verify}
            header_hash.merge!(:required => options[:required]) if options[:required]
            header_hash.merge!(:required => options[:optional]) if options[:optional]
            header_hash.merge!(:required => options[:policy_url]) if options[:policy_url]
          [401, {"WWW-Authenticate" => Rack::OpenID.build_header(header_hash)}, []]
        else
          present_login_options
        end
      end
    end

    def path
      env['PATH_INFO']
    end

    def present_login_options
      if login_path
        forward_to(login_path)
      else
        dir = File.dirname(__FILE__) + '/../'
        form = case options[:form]
        when 'boring'
          IO.read(dir + '/generic_openid_form.html.erb')
        when 'selector'
          IO.read(dir + '/nice_openid_form.html.erb')
        else # use default, real-openid selector
          IO.read(dir + '/nicer_openid_form.html.erb')
        end
        ok(form)
      end
    end

    def forward_to(url)
      [302, {'Location' => url,'Content-Type' => 'text/html'}, ["Forwarding to #{url}"]]
    end

    def allowed?
      if allowed_identifiers
        allowed_identifiers.include? verified_identifier
      elsif identity_match
        identity_match === verified_identifier
      else
        verified_identifier
      end
    end

    def identity_match
      options[:identity_match]
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
      @identitifier_to_verify ||=
      if env["rack.request.query_hash"] && env["rack.request.query_hash"]["openid_identifier"]
        env["rack.request.query_hash"]["openid_identifier"]
      elsif posted_data = CGI.parse(env['rack.input'].read)
        env['rack.input'].rewind
        identifier = posted_data['openid_identifier']
        if identifier.kind_of? Array
          identifier.last
        else
          identifier
        end
      end
    end

    def valid_identifier?
      uri = URI.parse(identitifier_to_verify.to_s.strip)
      uri = URI.parse("http://#{uri}") unless uri.scheme
      uri.scheme = uri.scheme.downcase  # URI should do this
      uri.normalize.to_s
    rescue URI::InvalidURIError
      # raise InvalidOpenId.new("#{url} is not an OpenID URL")
      false # Quietly fail for now.
    end

    def verified_identity=(hash)
      session['verified_identity'] = hash
    end

    def verified_identity
      session['verified_identity']
    end

    def verified_identifier
      verified_identity  && verified_identity['identifier']
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

    def ok(text, content_type = 'text/html')
      [200,{"Content-Type" => content_type},[text]]
    end

  end
end