class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  accepts_nested_attributes_for :sub_categories

  validates :name, presence: true
end
