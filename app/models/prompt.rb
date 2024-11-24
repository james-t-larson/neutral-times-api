class Prompt < ApplicationRecord
  has_paper_trail only: [ :text ]

  validates :text, presence: true
end
