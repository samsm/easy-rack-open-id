module EasyRackOpenid
  class Server
    def initialize(app, options ={})
      @app = app
      @options = options
    end

    def call(env)
      Processing.new(@app,@options).call(env)
    end
  end
end
