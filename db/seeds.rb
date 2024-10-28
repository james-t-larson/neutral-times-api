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
Article.destroy_all

article1 = article.create!(
  title: 'Breaking News: Ruby on Rails Rocks!',
  summary: 'A detailed article about how Ruby on Rails is a powerful web development framework.',
  published_at: Time.now,
  content: 'TESTING'
)

article2 = article.create!(
  title: 'The Future of AI in Web Development',
  summary: 'Exploring how AI is changing the web development landscape, with practical examples.',
  published_at: Time.now,
  content: 'TESTING'
)

puts "Seed data successfully created!"
