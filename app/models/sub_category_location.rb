class SubCategoryLocation < ApplicationRecord
  self.table_name = "sub_categories_locations"
  belongs_to :sub_category
  belongs_to :location
end
