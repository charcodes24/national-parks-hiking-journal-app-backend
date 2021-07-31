class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match('/national_parks/hikes/') && req.get?

      name = req.path.split("/national_parks/hikes/").last
      new_name = name.gsub!(/[20%]/, " ").squeeze(' ')
      park = NationalPark.find_by_name(new_name)
      hikes = park.hikes

      display_hikes = hikes.map do |t|
        {
          id: t.id, 
          name: t.name, 
          distance: t.distance,
          note: t.note
        }
      end

      return [200, { 'Content-Type' => 'application/json' }, [ {hikes: display_hikes, message: "request successful"}.to_json ]]

    elsif req.path.match(/national_parks/) && req.get?

      return [200, { 'Content-Type' => 'application/json' }, [ {national_parks: NationalPark.render_all, message: "request successful"}.to_json ]]

    elsif req.path.match(/national_parks/) && req.post?

      new_park = NationalPark.new(JSON.parse(req.body.read))

      if new_park.save
        return [200, { 'Content-Type' => 'application/json' }, [ {:park => new_park, :message => "park successfully added"}.to_json ]]
      else 
        return [422, { 'Content-Type' => 'application/json' }, [ {:error => "failed to create"}.to_json ]]
      end

    elsif req.path.match(/add_hikes/) && req.post?

      data = JSON.parse(req.body.read)
      hike_data = data["hike"]
      new_hike = Hike.new(hike_data)
      national_park_name = data["park"]["name"]
      national_park = NationalPark.find_by_name(national_park_name)
      national_park.hikes << new_hike
      binding.pry

      if new_hike
        return [200, { 'Content-Type' => 'application/json' }, [ {:hike => new_hike, :message => "hike successfully added"}.to_json ]]
      else 
        return [422, { 'Content-Type' => 'application/json' }, [ {:error => "failed to create"}.to_json ]]
      end

    elsif req.path.match(/national_parks/) && req.delete?

      id = req.path.split("/national_parks/").last
      park = NationalPark.find_by_id(id)

      if park.destroy
        return [200, { 'Content-Type' => 'application/json' }, [ {:message => "park successfully deleted"}.to_json ]]
      else
        return [422, { 'Content-Type' => 'application/json' }, [ {:error => "unable to delete park"}.to_json ]]
      end

    elsif req.path.match(/hikes/) && req.delete?

      id = req.path.split("/hikes/").last
      hike = Hike.find_by_id(id)

      if hike.destroy
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
