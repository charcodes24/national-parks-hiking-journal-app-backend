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
          difficulty: t.difficulty, 
          note: t.note
        }
      end

      return [200, { 'Content-Type' => 'application/json' }, [ {hikes: display_hikes, message: "request successful"}.to_json ]]

    elsif req.path.match(/national_parks/) && req.get?

      return [200, { 'Content-Type' => 'application/json' }, [ {national_parks: NationalPark.render_all, message: "request successful"}.to_json ]]

    elsif req.path.match(/national_parks/) && req.post?

      newPark = NationalPark.new(JSON.parse(req.body.read))

      if newPark.save
        return [200, { 'Content-Type' => 'application/json' }, [ {:park => newPark, :message => "park successfully added"}.to_json ]]
      else 
        return [422, { 'Content-Type' => 'application/json' }, [ {:error => "failed to create"}.to_json ]]
      end

    elsif req.path.match(/national_parks/) && req.delete?

      id = req.path.split("/national_parks/").last
      park = NationalPark.find_by_id(id)

      if park.destroy
        return [200, { 'Content-Type' => 'application/json' }, [ {:message => "task successfully deleted"}.to_json ]]
      else
        return [422, { 'Content-Type' => 'application/json' }, [ {:error => "unable to delete task"}.to_json ]]
      end

    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
