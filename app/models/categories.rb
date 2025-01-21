class Category < ApplicationRecord
  has_many :category_sub_categories, dependent: :destroy
  has_many :sub_categories, through: :category_sub_categories

  validates :category, presence: true
end
