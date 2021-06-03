class HelloWorld
  def call(env)
    [
      200,
      { "Content-Type" => "text/html" },
      ["Hello, world! (with Rack)"]
    ]
  end
end

app = HelloWorld.new

run(app)
