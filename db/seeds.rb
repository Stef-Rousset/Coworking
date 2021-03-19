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
puts 'delete offices'
Office.destroy_all
puts 'delete buildings'
Building.destroy_all


puts 'creating one user'
  User.create!(first_name: "paul", last_name: "martin", email: "paul.martin@gmail.com", password: "123456", admin: true)
puts "user done"

puts "creating buildings"

building_one = Building.create!(name: "Espace Foch", address: '55 avenue Foch 75007 Paris',
  description: "Situé dans un superbe immeuble haussmannien, au dernier étage, vous profiterez
  d'une vue incroyable sur Paris. Vous aurez le choix entre nos bureaux privatifs avec fenêtre, et
  notre grand espace de coworking.")
file_one = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616058648/building_one_j7hbtu.jpg')
building_one.photos.attach(io: file_one, filename: 'building_one', content_type: 'images/jpg')
photo_one = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616075343/office_one_private_mqrnau.jpg')
building_one.photos.attach(io: photo_one, filename: 'office_one_private', content_type: 'images/jpg')
photo_two = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616075355/office_one_cowork_dkp4uk.jpg')
building_one.photos.attach(io: photo_two, filename: 'office_one_cowork', content_type: 'images/jpg')

building_two = Building.create!(name: "Espace Chatelet", address: '150 rue de Chatelet 75001 Paris',
  description: 'Au coeur de Paris, au pied du métro Chatelet, vous pourrez vous déplacer facilement
  dans Pairs et sa banlieue grâce aux nombreuses station de métro et RER disponibles à Chatelet. Notre
  espace est également situé à proximité du centre commercial des Halles.')
file = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616058691/building_two_bh0wmy.jpg')
building_two.photos.attach(io: file, filename: 'building_two', content_type: 'images/jpg')
photo_one = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616076051/office_two_private_ter4vy.jpg')
building_two.photos.attach(io: photo_one, filename: 'office_two_private', content_type: 'images/jpg')
photo_two = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616076063/office_two_cowork_wffw3s.jpg')
building_two.photos.attach(io: photo_two, filename: 'office_two_cowork', content_type: 'images/jpg')

building_three = Building.create!(name: "Espace Pizay", address: "12 rue Pizay 69001 Lyon",
  description: 'Au centre de Lyon, proche de la gare, vous trouverez au sein de notre espace toutes
  les conditions pour travailler sereinement.')
file = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616058408/building_three_vzueem.jpg')
building_three.photos.attach(io: file, filename: 'building_three', content_type: 'images/jpg')
photo_one = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616076666/office_three_private_jsvszv.jpg')
building_three.photos.attach(io: photo_one, filename: 'office_three_private', content_type: 'images/jpg')
photo_two = URI.open('https://res.cloudinary.com/du5qhnalh/image/upload/v1616076655/office_three_cowork_t1ow2d.jpg')
building_three.photos.attach(io: photo_two, filename: 'office_three_cowork', content_type: 'images/jpg')

puts 'buildings done'
puts 'creating offices'

10.times do |number|
  price = 1.0
  space = "alone"
  name = "bureau-#{number + 1}"
  Office.create!(space: space, price: price, name: name, building_id: building_one.id)
end

20.times do |number|
  price = 0.5
  space = "cowork"
  name = "place-#{number + 1}"
  Office.create!(space: space, price: price, name: name, building_id: building_one.id)
end

10.times do |number|
  price = 1.0
  space = "alone"
  name = "bureau-#{number + 1}"
  Office.create!(space: space, price: price, name: name, building_id: building_two.id)
end

20.times do |number|
  price = 0.5
  space = "cowork"
  name = "place-#{number + 1}"
  Office.create!(space: space, price: price, name: name, building_id: building_two.id)
end

15.times do |number|
  price = 0.75
  space = "alone"
  name = "bureau-#{number + 1}"
  Office.create!(space: space, price: price, name: name, building_id: building_three.id)
end

20.times do |number|
  price = 0.25
  space = "cowork"
  name = "place-#{number + 1}"
  Office.create!(space: space, price: price, name: name, building_id: building_three.id)
end
puts "offices done"

