require_relative './init'

class CORS
  def initialize(app)
    @app = app
  end

  def call(env)
    response = @app.(env)

    headers = response[1]
    headers["Access-Control-Allow-Origin"] = "http://localhost:1234"
    headers["Access-Control-Allow-Headers"] = "Content-Type"

    response
  end
end

class NotFound
  def self.call(env)
    [404, {}, []]
  end
end

use(CORS)
use(Registration::Resource::Middleware)

run(NotFound)
