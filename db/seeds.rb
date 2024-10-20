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
Story.destroy_all
Content.destroy_all

# Create sample stories with content
story1 = Story.create!(
  title: 'Breaking News: Ruby on Rails Rocks!',
  summary: 'A detailed story about how Ruby on Rails is a powerful web development framework.',
  published_at: Time.now
)

story2 = Story.create!(
  title: 'The Future of AI in Web Development',
  summary: 'Exploring how AI is changing the web development landscape, with practical examples.',
  published_at: Time.now
)

# Create contents for the first story
story1.contents.create!(
  sub_title: 'Introduction to Ruby on Rails',
  text: 'Ruby on Rails, also known as Rails, is a server-side web application framework written in Ruby...'
)

story1.contents.create!(
  sub_title: 'Why Rails is Popular',
  text: 'Rails provides a convention over configuration structure, which allows developers to write less code...'
)

# Create contents for the second story
story2.contents.create!(
  sub_title: 'Introduction to AI in Web Development',
  text: 'AI is becoming an integral part of modern web applications. From chatbots to recommendation systems...'
)

story2.contents.create!(
  sub_title: 'Real-World AI Applications in Web Development',
  text: 'Many companies are integrating AI to enhance user experience and automate complex processes...'
)

puts "Seed data successfully created!"
