puts "Clearing old data..."
Hike.destroy_all
NationalPark.destroy_all

puts "Seeding National Parks..."

yosemite = NationalPark.new(name:"Yosemite National Park", image: "https://images.unsplash.com/photo-1498429089284-41f8cf3ffd39?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8eW9zZW1pdGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60")
sequoia = NationalPark.new(name:"Sequoia National Park", image: "https://images.unsplash.com/photo-1529025797902-c04dc9523016?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2VxdW9pYSUyMG5hdGlvbmFsJTIwcGFya3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60")
lassen = NationalPark.new(name:"Lassen Volcanic National Park", image: "https://images.unsplash.com/photo-1551637166-aa7f1889d41c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bGFzc2VuJTIwbmF0aW9uYWwlMjBwYXJrfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60")

puts "Seeding hikes..."
yosemite.hikes.build(
    name:"Upper Yosemite Falls", 
    distance: 7.6,
    note: "beautiful views of yosemite valley from the top", 
    )
yosemite.hikes.build(
    name: "Half Dome",
    distance: 16.3,
    note: "CRAZY!!"
)
yosemite.save

sequoia.hikes.build(
    name:"Moro Rock", 
    distance: 0.5, 
    note: "not really a hike.. more like a walk up a lot of stairs to a cool view"
)
sequoia.hikes.build(
    name:"Heather Lake", 
    distance: 12.3,  
    note: "Absolutely beautiful hike!!"
)
sequoia.save

lassen.hikes.build(
    name:"Brokeoff Mountain", 
    distance: 7.6, 
    note: "Great hike. Elevation gain almost the entire way up, but not too steep."
)
lassen.save

puts "Done!"
