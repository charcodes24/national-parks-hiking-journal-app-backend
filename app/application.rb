class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    #GET response to load hikes for specific national park (on FullCard component)
    if req.path.match('/national_parks/hikes/') && req.get?

      name = req.path.split('/national_parks/hikes/').last
      park = NationalPark.find_by_name(name.gsub!('_', ' '))

      return [200, { 'Content-Type' => 'application/json' }, [ {hikes: park.display_hikes, message: "request successful"}.to_json ]]


    #GET response to load all national parks (on Container component)
    elsif req.path.match('/national_parks/') && req.get?

      return [200, { 'Content-Type' => 'application/json' }, [ {national_parks: NationalPark.render_all, message: "request successful"}.to_json ]]

    #POST response to add national park (on AddParkForm component)
    elsif req.path.match('/national_parks/') && req.post?

      new_park = NationalPark.new(JSON.parse(req.body.read))
      
      if new_park.save
        return [200, { 'Content-Type' => 'application/json' }, [ {:park => new_park, :message => "park successfully added"}.to_json ]]
      else 
        return [422, { 'Content-Type' => 'application/json' }, [ {:error => "failed to create"}.to_json ]]
      end

      #POST response to add hikes (on AddHikeForm component)
    elsif req.path.match('/add_hikes/') && req.post?
      data = JSON.parse(req.body.read)
      new_hike = Hike.new(data["hike"])
      national_park = NationalPark.find_by_name(data["park"]["name"])

      if national_park.hikes << new_hike
        return [200, { 'Content-Type' => 'application/json' }, [ {:hike => new_hike, :message => "hike successfully added"}.to_json ]]
      else 
        return [422, { 'Content-Type' => 'application/json' }, [ {:error => "failed to create"}.to_json ]]
      end

    elsif req.path.match(/national_parks/) && req.delete?

      if NationalPark.find_by_path(req.path).destroy
        return [200, { 'Content-Type' => 'application/json' }, [ {:message => "park successfully deleted"}.to_json ]]
      else
        return [422, { 'Content-Type' => 'application/json' }, [ {:error => "unable to delete park"}.to_json ]]
      end

    elsif req.path.match('/hikes/') && req.delete?

      if Hike.find_by_path(req.path).destroy
        return [200, { 'Content-Type' => 'application/json' }, [ {:message => "park successfully deleted"}.to_json ]]
      else
        return [422, { 'Content-Type' => 'application/json' }, [ {:error => "unable to delete hike"}.to_json ]]
      end

    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
