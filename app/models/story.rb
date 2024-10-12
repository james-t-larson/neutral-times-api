class Story < ApplicationRecord
  has_many :contents, dependent: :destroy
  accepts_nested_attributes_for :contents, allow_destroy: true
end
