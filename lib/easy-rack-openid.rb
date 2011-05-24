require File.dirname(__FILE__) + '/easy-rack-openid/server'
require File.dirname(__FILE__) + '/easy-rack-openid/processing'

module EasyRackOpenid
  def initialize(app, options ={})
    @app = app
    @options = options
  end

  def call(env)
    Processing.new(@app,@options).call(env)
  end
end
