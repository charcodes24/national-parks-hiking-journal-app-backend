class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match('/national_parks/') && req.get?

      return [200, { 'Content-Type' => 'application/json' }, [ {national_parks: NationalPark.render_all, message: "request successful"}.to_json ]]

    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
