class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :sub_categories_locations, class_name: "SubCategoryLocation", dependent: :destroy
  has_many :locations, through: :sub_categories_locations, dependent: :destroy
  accepts_nested_attributes_for :locations

  validates :name, presence: true
end
