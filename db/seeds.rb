# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require "open-uri"

Vinyl.destroy_all
Slot.destroy_all
User.destroy_all
puts "Old data destroyed."

user1 = User.create!(
  email: "demo@vinyleflow.com",
  first_name: "Yoann",
  last_name: "Leblanc",
  password: "password"
)
puts "User created."

vinyls_data = [
  {
    title: "Enter the Wu-Tang (36 Chambers)",
    artist: "Wu-Tang Clan",
    genre: "Hip Hop",
    release_year: 1993,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648940/vinyle%20flow/wu.jpg"
  },
  {
    title: "Speakerboxxx/The Love Below",
    artist: "Outkast",
    genre: "Hip Hop",
    release_year: 2003,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648935/vinyle%20flow/Outkast.jpg"
  },
  {
    title: "Adios Bahamas",
    artist: "Népal",
    genre: "Hip Hop",
    release_year: 2020,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648933/vinyle%20flow/Nepal.jpg"
  },
  {
    title: "Straight Outta Compton",
    artist: "N.W.A.",
    genre: "Hip Hop",
    release_year: 1988,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648929/vinyle%20flow/NWA.jpg"
  },
  {
    title: "Pline",
    artist: "Vésuve",
    genre: "Rock Expérimental",
    release_year: 2023,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744651537/vinyle%20flow/vesuve.jpg"
  },
  {
    title: "Colors",
    artist: "Sport",
    genre: "Emo Punk",
    release_year: 2014,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648936/vinyle%20flow/Sport.jpg"
  },
  {
    title: "Good Kid, M.A.A.D City",
    artist: "Kendrick Lamar",
    genre: "Hip Hop",
    release_year: 2012,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648927/vinyle%20flow/Kendrick_good_kid_maad_city.jpg"
  },
  {
    title: "DAMN.",
    artist: "Kendrick Lamar",
    genre: "Hip Hop",
    release_year: 2017,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648925/vinyle%20flow/Kendrick_DAMN.jpg"
  },
  {
    title: "Ghost Dog: The Way of the Samurai",
    artist: "RZA",
    genre: "OST",
    release_year: 1999,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648917/vinyle%20flow/Ghost_Dog.jpg"
  },
  {
    title: "Antidotes",
    artist: "Foals",
    genre: "Indie Rock",
    release_year: 2008,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648916/vinyle%20flow/Foals.jpg"
  },
  {
    title: "Secrets / Monsters",
    artist: "Herbie Hancock",
    genre: "Jazz Funk",
    release_year: 1973,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648919/vinyle%20flow/Herbie_Hancock.jpg"
  },
  {
    title: "The One Above",
    artist: "Hubris.",
    genre: "Post-Rock",
    release_year: 2020,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744648923/vinyle%20flow/Hubris.jpg"
  },
  {
    title: "Fantôme avec chauffeur",
    artist: "Benjamin Epps",
    genre: "Rap",
    release_year: 2021,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744818305/benjamin_epps_fantome_avec_chauffeur_abvknf.jpg"
  },
  {
    title: "Le Futur",
    artist: "Benjamin Epps",
    genre: "Rap",
    release_year: 2022,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744818306/benjamin_epps_le_futur_swrw9z.jpg"
  },
  {
    title: "Vous êtes pas contents ? Triplé !",
    artist: "Benjamin Epps",
    genre: "Rap",
    release_year: 2023,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744818306/benjamin_epps_vous_etes_pas_content_triple_wpuaxi.jpg"
  },
  {
    title: "Ipséité",
    artist: "Damso",
    genre: "Rap",
    release_year: 2017,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744818308/damso_ipseite_iyvgyk.jpg"
  },
  {
    title: "Animals",
    artist: "Pink Floyd",
    genre: "Progressive Rock",
    release_year: 1977,
    image_url: "https://res.cloudinary.com/dmrxyk62j/image/upload/v1744818309/pink_floyd_animals_ileauw.jpg"
  }
]
vinyls_data.each do |vinyl_data|
  vinyl = Vinyl.new(
    title: vinyl_data[:title],
    artist: vinyl_data[:artist],
    genre: vinyl_data[:genre],
    release_year: vinyl_data[:release_year],
    user: user1
  )

  file = URI.open(vinyl_data[:image_url])

  vinyl.photo.attach(io: file, filename: "#{vinyl_data[:title].parameterize}.jpg", content_type: "image/jpg")

  vinyl.save!
  puts "Created: #{vinyl.title} by #{vinyl.artist}"
end
