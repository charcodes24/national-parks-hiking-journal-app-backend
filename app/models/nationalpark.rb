class NationalPark < ActiveRecord::Base 
    has_many :hikes
end