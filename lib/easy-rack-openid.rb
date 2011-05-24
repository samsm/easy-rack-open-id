require File.dirname(__FILE__) + '/easy-rack-open-id/server'
require File.dirname(__FILE__) + '/easy-rack-open-id/processing'

module EasyRackOpenId
  def initialize(app, options ={})
    @app = app
    @options = options
  end

  def call(env)
    Processing.new(@app,@options).call(env)
  end
end
