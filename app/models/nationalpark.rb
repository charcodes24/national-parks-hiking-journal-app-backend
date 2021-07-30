class NationalPark < ActiveRecord::Base 
    has_many :hikes

    def self.render_all 
        self.all.map do |t|
            {
                id: t.id, 
                name: t.name, 
                image: t.image
            }
        end
    end

    def self.find_park_by_path(path)
        id = req.path.split("/national_parks/").last
        NationalPark.find_by_id(id)
    end
end