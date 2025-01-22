class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  has_many :categories_locations, class_name: "CategoryLocation", dependent: :destroy
  has_many :locations, through: :categories_locations, dependent: :destroy

  accepts_nested_attributes_for :sub_categories
  accepts_nested_attributes_for :locations

  validates :name, presence: true
end
