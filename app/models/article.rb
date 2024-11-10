class Article < ApplicationRecord
  validates :title, :summary, :content, :sources, presence: true

  scope :published_today, -> { where(created_at: Time.now.beginning_of_day..Time.now.end_of_day) }
  scope :published_between, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
  scope :recent, -> { where(created_at: 7.days.ago.beginning_of_day..Time.now.end_of_day) }
end
