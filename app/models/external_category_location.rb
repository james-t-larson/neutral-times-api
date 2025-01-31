class ExternalCategoryLocation < ApplicationRecord
  self.table_name = "external_categories_locations"
  belongs_to :external_category
  belongs_to :location
end
