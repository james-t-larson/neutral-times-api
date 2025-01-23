module Services
  module EventRegistry
    class DataPreperation
      def prepare
        set_internal_categories
        sorted = sort(@internal_categories)
        grouped = group(sorted)
        serialized_locations = Serializers::EventRegistry::Location(grouped.first.locations)
        serialized_categories = Serializers::EventRegistry::Categories(grouped)

        {
          locations: serialized_locations,
          categories: serialized_categories
        }
      end

      def set_internal_categories
        @internal_categories ||= Category.first
      end

      def self.group(categories)
        grouped_categories = []

        window_start = 0
        group_count = 0
        0.upto(categories.length - 2).each do |index|
          next_length = categories[index + 1].locations.length
          if next_length > categories[index].locations.length

            grouped_categories[group_count] = categories[window_start..(index + 1)]
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
end
