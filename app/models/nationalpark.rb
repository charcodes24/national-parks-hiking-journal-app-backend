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
end