class Prompt < ApplicationRecord
  has_paper_trail only: [ :text, :sentiment, :usage_count ]

  validates :text, presence: true
  validate :only_one_prompt_allowed, on: :create

  scope :current, -> { first }

  private

  def only_one_prompt_allowed
    if Prompt.exists?
      errors.add(:base, "Only one prompt can exist at a time.")
    end
  end
end
