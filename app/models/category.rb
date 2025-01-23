class Category < ApplicationRecord
  has_many :external_categories, dependent: :destroy
  has_many :categories_locations, class_name: "CategoryLocation", dependent: :destroy
  has_many :locations, through: :categories_locations

  accepts_nested_attributes_for :external_categories
  accepts_nested_attributes_for :locations

  validates :name, presence: true
end
