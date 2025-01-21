Categories.destory_all
Categories.create(
  [
    {
      name: "Sports",
      sub_categories_attributes: [
        {
          name: "dmoz/Sports/Football/American",
          locations_attributes: [ { name: 'United States' }, { name: 'Canada' } ]
        },
        {
          name: "dmoz/Sports/Football/Rugby_Union",
          locations_attributes: [ { name: 'United States' }, { name: 'Canada' } ]
        },
        {
          name: "dmoz/Sports/Hockey",
          locations_attributes: [ { name: 'United States' }, { name: 'Canada' } ]
        },
        {
          name: "dmoz/Society/Issues",
          locations_attributes: [ { name: 'United States' }, { name: 'Canada' } ]
        }
      ]
    }
  ]
).save
