module EventRegistry
  class DataPreperation
    def self.prepare(category)
      sorted = sort(category.external_categories)
      grouped = group_and_serialize(sorted, category)
      grouped
    end

    def self.group_and_serialize(sorted, category)
      grouped_categories = []

      window_start = 0
      group_count = 0
      puts sorted.length - 2
      0.upto(sorted.length - 1).each do |index|
        next_length = sorted[index + 1]&.locations&.length
        current_length = sorted[index].locations.length
        if index == sorted.length - 1 || next_length > current_length
          locations = category.locations.to_a + sorted[index].locations.to_a
          category_group = sorted[window_start..index]
          serialized_categories = EventRegistry::Category.serialize(category_group)
          serialized_locations =  EventRegistry::Location.serialize(locations)

          grouped_categories[group_count] = {
            internal_category_id: category.id,
            external_categories: serialized_categories,
            locations: serialized_locations
          }

          group_count += 1
          window_start = index + 1
        end
      end

      grouped_categories
    end

    def self.sort(categories)
      categories.sort_by { |category| category.locations.count }
    end
  end
end
