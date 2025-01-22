name = "Technology"
puts "Starting seeding the #{name} Category"
Category.find_by(name: name)&.destroy
Category.create(
  [
    {
      name: name,
      position: 4,
      locations_attributes: [ { name: 'United States' }, { name: 'Canada' } ],
      sub_categories_attributes: [
        {
          name: "news/Technology"
        },
        {
          name: "dmoz/Computers"
        },
        {
          name: "dmoz/Science/Technology"
        },
        {
          name: "dmoz/Science/Software"
        },
        {
          name: "dmoz/Home/Software"
        },
        {
          name: "dmoz/Sports/Software"
        },
        {
          name: "dmoz/Business/Information_Technology"
        },
        {
          name: "dmoz/Business/Investing/Software"
        },
        {
          name: "dmoz/Arts/Graphic_Design/Software"
        },
        {
          name: "dmoz/Society/Subcultures/Cyberculture"
        },
        {
          name: "dmoz/Business/Aerospace_and_Defense/Space"
        },
        {
          name: "dmoz/Business/Arts_and_Entertainment/Gaming"
        }
      ]
    }
  ]
)
