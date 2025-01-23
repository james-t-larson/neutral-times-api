name = "Civics"
puts "Starting seeding the #{name} Category"
Category.find_by(name: name)&.destroy
Category.create(
  [
    {
      name: name,
      position: 2,
      locations_attributes: [ { name: "Colorado" }, { name: "Oregon" }, { name: "British_Columbia" } ],
      external_categories_attributes: [
        {
          name: "dmoz/Health/Mental_Health"
        },
        {
          name: "dmoz/Health/Men's_Health"
        },
        {
          name: "dmoz/Business/Healthcare"
        },
        {
          name: "dmoz/Health/Aging"
        },
        {
          name: "dmoz/Health/Child_Health"
        },
        {
          name: "dmoz/Health/Mental_Health"
        },
        {
          name: "dmoz/Health/Occupational_Health_and_Safety"
        },
        {
          name: "dmoz/Society/Issues"
        },
        {
          name: "dmoz/Society/Crime"
        },
        {
          name: "dmoz/Business/Cooperatives"
        },
        {
          name: "dmoz/Society/Law"
        },
        {
          name: "dmoz/Society/Government"
        },
        {
          name: "dmoz/Society/Crime"
        },
        {
          name: "dmoz/Society/Activism"
        },
        {
          name: "dmoz/Health/Education"
        },
        {
          name: "dmoz/Business/Real_Estate/Development"
        },
        {
          name: "dmoz/Business/Real_Estate/Residential"
        },
        {
          name: "dmoz/Business/Real_Estate/Inspection"
        },
        {
          name: "dmoz/Business/Real_Estate/Legal"
        },
        {
          name: "dmoz/Society/Philanthropy/Homeless"
        },
        {
          name: "dmoz/Society/Politics/Democracy",
          locations_attributes: [ { name: "Washington,_D.C." }, { name: "Ottawa" } ]
        },
        {
          name: "dmoz/Society/Organizations/Advocacy"
        },
        {
          name: "dmoz/Health/Public_Health_and_Safety"
        },
        {
          name: "dmoz/Business/Construction_and_Maintenance/Residential_Housing"
        },
        {
          name: "dmoz/Health/Public_Health_and_Safety/Community_Health"
        },
        {
          name: "dmoz/Society/Politics/Campaigns_and_Elections",
          locations_attributes: [ { name: "Washington,_D.C." }, { name: "Ottawa" } ]
        },
        {
          name: "dmoz/Health/Public_Health_and_Safety/Policy_and_Regulation",
          locations_attributes: [ { name: "Washington,_D.C." }, { name: "Ottawa" } ]
        },
        {
          name: "dmoz/Society/Issues/Human_Rights_and_Liberties",
          locations_attributes: [ { name: "Washington,_D.C." }, { name: "Ottawa" } ]
        },
        {
          name: "dmoz/Society/Politics/Civic_Participation",
          locations_attributes: [ { name: "Canada" }, { name: "Ottawa" }, { name: "United_States" }, { name: "Washington._D.C." } ]
        },
        {
          name: "dmoz/Society/Politics/Conservatism"
        },
        {
          name: "dmoz/Society/Politics/Fascism"
        },
        {
          name: "dmoz/Society/Politics/Federalism_and_Devolution"
        }
      ]
    }
  ]
)
