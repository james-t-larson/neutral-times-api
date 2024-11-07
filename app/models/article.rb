class Article < ApplicationRecord
  validates :title, presence: true
  validates :summary, presence: true
  validates :content, presence: true
  validates :sources, presence: true

  scope :published_today, -> { where(created_at: Time.now.beginning_of_day..Time.now.end_of_day) }
end
