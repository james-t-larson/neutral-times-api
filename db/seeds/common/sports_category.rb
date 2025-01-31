name = "Sports"
puts "Starting seeding the #{name} Category"
Category.find_by(name: name)&.destroy
Category.create(
  [
    {
      name: name,
      position: 5,
      locations_attributes: [ { name: 'United_States' }, { name: 'Canada' } ],
      external_categories_attributes: [
        {
          name: "dmoz/Sports/Football/Canadian"
        },
        {
          name: "dmoz/Sports/Football/American"
        },
        {
          name: "dmoz/Sports/Football/Rugby_Union"
        },
        {
          name: "dmoz/Sports/Hockey"
        }
      ]
    }
  ]
)
