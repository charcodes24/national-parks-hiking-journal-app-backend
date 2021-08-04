class NationalPark < ActiveRecord::Base 
    has_many :hikes

    def self.render_all 
        NationalPark.all.map do |t|
            {
                id: t.id, 
                name: t.name, 
                image: t.image
            }
        end
    end

    def self.find_by_path(path)
        id = path.split("/national_parks/").last
        find_by_id(id)
    end

    def display_hikes
        self.hikes do |t|
            {
                id: t.id, 
                name: t.name, 
                distance: t.distance,
                note: t.note 
            }
        end
    end
end