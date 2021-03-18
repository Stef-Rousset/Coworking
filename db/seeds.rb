# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

puts 'delete users'
User.destroy_all
puts 'delete buildings'
Building.destroy_all

puts 'creating first user'
  User.create!(first_name: "paul", last_name: "martin", email: "paul.martin@gmail.com", password: "123456")
puts "first user done"

puts "creating 5 random users"

5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  password = Faker::String.random(length: 6..10)
  User.create!(first_name: first_name, last_name: last_name, email: email, password: password)
end

puts 'users done'

puts "creating buildings"

building_one = Building.create!(name: "Espace Foch", address: '55 avenue Foch', city: 'Paris',
  description: 'Situé dans un superbe immeuble haussmannien, vous aurez le choix entre des
  bureaux privatifs équipés ou des espaces de coworking')
file = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616058648/building_one_j7hbtu.jpg')
building_one.photo.attach(io: file, filename: 'building_one', content_type: 'images/jpg')

building_two = Building.create!(name: "Espace Chatelet", address: '150 rue de Chatelet', city: 'Paris',
  description: 'Au coeur de Paris, au pied du métro Chatelet, notre espace met à votre
  disposition des bureaux privés, mais aussi un grand espace de coworking.')
file = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616058691/building_two_bh0wmy.jpg')
building_two.photo.attach(io: file, filename: 'building_two', content_type: 'images/jpg')

building_three = Building.create!(name: "Espace Pizay", address: "12 rue Pizay", city: 'Lyon',
  description: 'Au centre de Lyon, proche de la gare, vous trouverez au sein de notre espace toutes
  les conditions pour travailler sereinement.')
file = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616058408/building_three_vzueem.jpg')
building_three.photo.attach(io: file, filename: 'building_three', content_type: 'images/jpg')

puts 'buildings done'
