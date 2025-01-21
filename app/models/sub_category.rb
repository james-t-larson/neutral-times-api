class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :locations, dependent: :destroy
  accepts_nested_attributes_for :locations

  validates :name, presence: true
end
