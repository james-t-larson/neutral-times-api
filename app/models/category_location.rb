class CategoryLocation < ApplicationRecord
  self.table_name = "categories_locations"
  belongs_to :category
  belongs_to :location
end
