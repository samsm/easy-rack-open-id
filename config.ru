require 'rubygems'
require 'rack'
# require 'rack/openid'
require 'vendor/rack-openid/lib/rack/openid'
require 'lib/easy_rack_open_id'

use Rack::ShowExceptions

class HelloWorld
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["Made it through!"]]
  end
end


# require 'openid_mongodb_store'
# MongoMapper.database = 'testorama'
puts "Remember shotgun won't work with memory store!"

use Rack::Session::Cookie
use Rack::OpenID #, OpenidMongodbStore::Store.new
use EasyRackOpenID, :allowed_identifiers => ['http://samsm.com/'], :after_logout_path => '/login', :required => ['nickname']
run HelloWorld.new
