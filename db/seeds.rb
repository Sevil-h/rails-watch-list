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
Bookmark.destroy_all
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

list_one = List.new(name: "Favorite Movies")
file = URI.open('https://i.pinimg.com/564x/fd/0c/f3/fd0cf3a84a6c88dbfa726c779eb5bf89.jpg')
list_one.photo.attach(io: file, filename: 'temp.jpg', content_type: 'image.jpg')
list_one.save

list_two = List.create(name: 'Romantic Movies')
file = URI.open('https://i.pinimg.com/474x/a0/6a/ed/a06aedf5dbfe4619bbc11791cf9d14ee.jpg')
list_two.photo.attach(io: file, filename: 'temp.jpg', content_type: 'image.jpg')
list_two.save

list_four = List.create(name: 'Animation')
file = URI.open('https://i.pinimg.com/474x/c7/e5/64/c7e5642fa85fd39d63163a05e42adc05.jpg')
list_four.photo.attach(io: file, filename: 'temp.jpg', content_type: 'image.jpg')
list_four.save

list_five = List.create(name: 'Classic Movies')
file = URI.open('https://i.pinimg.com/474x/77/0c/e7/770ce7ba03936a5083e8dfbc3091af90.jpg')
list_five.photo.attach(io: file, filename: 'temp.jpg', content_type: 'image.jpg')
list_five.save

puts "#{List.count} list created"
