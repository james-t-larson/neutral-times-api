class Article < ApplicationRecord
  default_scope { order(:relevance) }

  validates :title, :summary, :content, :sources, presence: true

  scope :recent, -> { where(created_at: 7.days.ago.beginning_of_day..Time.now.end_of_day) }
  scope :published_today, -> { where(created_at: Time.now.beginning_of_day..Time.now.end_of_day) }
  scope :published_between, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }

  scope :published_on, ->(date) {
    where(created_at: date.beginning_of_day..date.end_of_day)
  }

  scope :by_category, ->(category) {
    return all if category == nil
    first_category_id = Category.all.first&.id
    first_category_id == category.id ? all : where(category_id: category&.id)
  }

  scope :last_batch_published, -> {
    if (last_article = order(created_at: :desc).first)
      published_on(last_article.created_at.to_date)
    else
      none
    end
  }
end
