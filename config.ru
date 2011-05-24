require 'rubygems'
require 'rack'
require 'rack/openid'
require 'lib/easy-rack-open-id'

use Rack::ShowExceptions

class HelloWorld
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["Made it through! (<a href='/logout'>logout</a>)"]]
  end
end

# require 'openid_mongodb_store'

puts "Remember shotgun won't work with memory store!"

use Rack::Session::Cookie
use Rack::OpenID #, OpenidMongodbStore::Store.new(Mongo::Connection.new.db('testorama'))
use EasyRackOpenId::Server, :allowed_identifiers => ['http://samsm.com/'], :after_logout_path => '/login', :required => ['nickname']
run HelloWorld.new
