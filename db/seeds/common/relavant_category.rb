name = "Relavant"
puts "Starting seeding the #{name} Category"
Category.find_by(name: name)&.destroy
Category.create(
  [
    {
      name: name,
      position: 1
    }
  ]
)
