# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Destoying all events"
Event.destroy_all

require "open-uri"
puts "Creating events_seeds"

  file = URI.open("https://res.cloudinary.com/dskpu0jqu/image/upload/v1666311274/CROWD/2_abp7fy.png")
  event = Event.new(
    event_date: "3-3-2023",
    address: "Estadio de Fútbol Atanasio Giradot",
    event_capacity: 45000,
    event_name: "Clásico Paisa",
    event_price: 20
  )
  event.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  event.save

  file2 = URI.open("https://res.cloudinary.com/dskpu0jqu/image/upload/v1666311274/CROWD/5_mb7mtf.png")
  event2 = Event.new(
    event_date: "3-3-2023",
    address: "Estadio de Fútbol Atanasio Giradot",
    event_capacity: 50000,
    event_name: "Clásico Capitalino",
    event_price: 20
  )
  event2.photo.attach(io: file2, filename: "nes.png", content_type: "image/png")
  event2.save

  file3 = URI.open("https://res.cloudinary.com/dskpu0jqu/image/upload/v1666311274/CROWD/4_ior6lx.png")
  event3 = Event.new(
    event_date: "3-3-2023",
    address: "Estadio de Fútbol Atanasio Giradot",
    event_capacity: 40000,
    event_name: "Clásico Valluno",
    event_price: 20
  )
  event3.photo.attach(io: file3, filename: "nes.png", content_type: "image/png")
  event3.save

  file4 = URI.open("https://res.cloudinary.com/dskpu0jqu/image/upload/v1666311274/CROWD/3_yqntlo.png")
  event4 = Event.new(
    event_date: "3-3-2023",
    address: "Estadio de Fútbol Atanasio Giradot",
    event_capacity: 50000,
    event_name: "Clásico Costeño",
    event_price: 20
  )
  event4.photo.attach(io: file4, filename: "nes.png", content_type: "image/png")
  event4.save

  file5 = URI.open("https://res.cloudinary.com/dskpu0jqu/image/upload/v1666311275/CROWD/7_e4mvmo.png")
  event5 = Event.new(
    event_date: "3-3-2023",
    address: "Estadio de Fútbol Atanasio Giradot",
    event_capacity: 20000,
    event_name: "Clásico Felino",
    event_price: 10
  )
  event5.photo.attach(io: file5, filename: "nes.png", content_type: "image/png")
  event5.save

  file6 = URI.open("https://res.cloudinary.com/dskpu0jqu/image/upload/v1666311275/CROWD/8_an2up2.png")
  event6 = Event.new(
    event_date: "3-3-2023",
    address: "Estadio de Fútbol Atanasio Giradot",
    event_capacity: 20000,
    event_name: "Clásico del Cuy",
    event_price: 10
  )
  event6.photo.attach(io: file6, filename: "nes.png", content_type: "image/png")
  event6.save

puts "6 events_seeds have been created"

puts "Destoying all users"
User.destroy_all

user_one = User.new(
  email: "user_one@test.com",
  password: "123456",
  name: "Manuela",
  last_name: "Torres",
  identification_number: "3457889",
  admin: false
)
photo_one = URI.open("https://res.cloudinary.com/drou5v6v6/image/upload/v1664644361/development/quhnhg9qdvjdp38bica4mgne2kwd.jpg")
user_one.photo.attach(io: photo_one, filename: "nes.png", content_type: "image/png")
user_one.save

user_two = User.new(
  email: "user_two@test.com",
  password: "123456",
  name: "Sebastian",
  last_name: "Naranjo",
  identification_number: "3434589",
  admin: true
)
photo_two = URI.open("https://res.cloudinary.com/drou5v6v6/image/upload/v1667146298/development/WhatsApp_Image_2022-10-12_at_8.14.43_PM_pyewyv.jpg")
user_two.photo.attach(io: photo_two, filename: "nes.png", content_type: "image/png")
user_two.save

puts "2 users_seeds have been created"
