class Prompt < ApplicationRecord
  has_paper_trail only: [ :text, :sentiment, :usage_count ]

  validates :text, presence: true

  scope :current, -> { where(id: 1).first }
end
