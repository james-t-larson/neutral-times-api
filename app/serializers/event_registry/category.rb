module EventRegistry
  class Category
    def self.serialize(categories)
      categories.map do |category|
        {
          "categoryUri": category.name
        }
      end
    end
  end
end
