name = "Finance"
puts "Starting seeding the #{name} Category"
Category.find_by(name: name)&.destroy
Category.create(
  [
    {
      name: name,
      position: 3,
      locations_attributes: [ { name: "Colorado" }, { name: "Oregon" }, { name: "British_Columbia" } ],
      external_categories_attributes: [
        {
          name: "dmoz/Home/Personal_Finance"
        },
        {
          name: "dmoz/Society/Issues/Economic"
        },
        {
          name: "dmoz/Business/Small_Business/Finance"
        },
        {
          name: "dmoz/Business/Investing",
          locations_attributes: [ { name: "New_York_City" } ]
        },
        {
          name: "dmoz/Business/Financial_Services"
        },
        {
          name: "dmoz/Business/Real_Estate"
        }
      ]
    }
  ]
)
