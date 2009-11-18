require 'rubygems'
require 'rack'
require 'rack/openid'
require 'lib/easy_rack_open_id'

use Rack::ShowExceptions

class HelloWorld
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["Made it through!"]]
  end
end


# require 'openid_mongodb_store'
# MongoMapper.database = 'testorama'

use Rack::Session::Cookie
use Rack::OpenID #, OpenidMongodbStore::Store.new
use EasyRackOpenID, :allowed_identifiers => ['http://example.com/'], :after_logout_path => '/login'
run HelloWorld.new
