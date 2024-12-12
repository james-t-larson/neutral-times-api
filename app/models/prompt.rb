class Prompt < ApplicationRecord
  before_commit :reset_analytics_values, on: :update
  has_paper_trail only: [ :text, :sentiment, :usage_count ]

  validates :text, presence: true
  validate :only_one_prompt_allowed, on: :create

  scope :current, -> { first }

  private

  def reset_analytics_values
    if saved_change_to_text?
      update_columns(sentiment: 0, usage_count: 0)
    end
  end

  def only_one_prompt_allowed
    if Prompt.exists?
      errors.add(:base, "Only one prompt can exist at a time.")
    end
  end
end
