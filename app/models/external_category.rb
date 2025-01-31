class ExternalCategory < ApplicationRecord
  belongs_to :category
  has_many :external_categories_locations, class_name: "ExternalCategoryLocation", dependent: :destroy
  has_many :locations, through: :external_categories_locations
  accepts_nested_attributes_for :locations

  validates :name, presence: true
end
