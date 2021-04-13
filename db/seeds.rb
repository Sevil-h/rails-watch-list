require 'open-uri'
require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning up database..."
Movie.destroy_all
List.destroy_all
puts "Database cleaned"

url = "http://tmdb.lewagon.com/movie/top_rated"
10.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
      rating: movie['vote_average']
    )
  end
end
puts "#{Movie.count} Movies created"

list_one = List.new(name: 'Classic Movies')
file = URI.open('https://i.pinimg.com/474x/b7/24/9a/b7249a12e56d287fb33a89de2c210c86.jpg')
list_one.photo.attach(io: file, filename: 'temp.jpg', content_type: 'image.jpg')
list_one.save

list_two = List.create(name: 'Romantic Movies')
file = URI.open('https://i.pinimg.com/564x/57/e1/7d/57e17de4cf8bc6bed5674852d2db8dd3.jpg')
list_two.photo.attach(io: file, filename: 'temp.jpg', content_type: 'image.jpg')
list_two.save

list_four = List.create(name: '90s Movies')
file = URI.open('https://i.pinimg.com/474x/ac/8e/16/ac8e1697d0556fa8c1c43abfb017cc44.jpg')
list_four.photo.attach(io: file, filename: 'temp.jpg', content_type: 'image.jpg')
list_four.save

list_five = List.create(name: '2000s Movies')
file = URI.open('https://i.pinimg.com/474x/86/9c/68/869c68d07afae1a32560a35b039fd81f.jpg')
list_five.photo.attach(io: file, filename: 'temp.jpg', content_type: 'image.jpg')
list_five.save

puts "#{List.count} list created"
