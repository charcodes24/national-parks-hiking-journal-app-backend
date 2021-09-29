class Hike < ActiveRecord::Base 
    belongs_to :national_park

    def self.find_by_path(path)
        id = path.split('/hikes/').last
        find_by_id(id)
    end

    #string w name of hike and national park belongs to
    def string 
        return "hello"
        "#{self.name} is in #{self.national_park.name}."
    end

end