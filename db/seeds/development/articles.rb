puts "Starting seeding articles"
Article.find_or_create_by!(
  title: "Breaking News: Ruby on Rails Rocks!",
  summary: "A detailed article about how Ruby on Rails is a powerful web development framework.",
  content: "TESTING",
  sources: "TESTING",
  category_id: Category.second.id
)

Article.find_or_create_by!(
  title: "The Future of AI in Web Development",
  summary: "Exploring how AI is changing the web development landscape, with practical examples.",
  content: "TESTING",
  sources: "TESTING",
  category_id: Category.first.id
)
