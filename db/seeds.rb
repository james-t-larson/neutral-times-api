# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
# # Clear existing data (optional, if you want to start fresh)

puts "Starting seeding process..."

def run_seeds(files)
  Dir[Rails.root.join(files)].each do |seed|
    load seed
  end
end

seeds_directories = [
  'db/seeds/common/*.rb',
  "db/seeds/#{Rails.env}/*.rb"
]

for directory in seeds_directories do
  run_seeds(directory)
end

puts "Seeding process completed!"
