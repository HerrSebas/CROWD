# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
puts "creating seed"

  file = URI.open("https://res.cloudinary.com/dskpu0jqu/image/upload/v1666139419/qgqkqdd2cl0mckisrhgl.jpg")
  event = Event.new(
    event_date: "3-3-2023",
    event_location: "Merida",
    event_capacity: 2000,
    event_name: "Tequila Match",
    event_latitude: "20.9753700",
    event_longitude: "-89.6169600",
    event_price: 20
  )
  event.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  event.save

puts "seeds have been created"
