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

common_seeds = Rails.root.join("db", "seeds", "common.rb")
require common_seeds if File.exist?(common_seeds)

environment_seeds = Rails.root.join("db", "seeds", "#{Rails.env}.rb")
require environment_seeds if File.exist?(environment_seeds)

puts "Seeding process completed!"
