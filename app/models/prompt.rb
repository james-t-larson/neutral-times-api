class Prompt < ApplicationRecord
  has_paper_trail only: [ :text ]

  validates :text, presence: true

  scope :current, -> { where(id: 1).first }
end
