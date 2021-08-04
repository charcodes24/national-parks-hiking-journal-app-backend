class Hike < ActiveRecord::Base 
    belongs_to :national_park

    def self.find_by_path(path)
        id = path.split('/hikes/').last
        find_by_id(id)
    end
end