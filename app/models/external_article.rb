class ExternalArticle < ApplicationRecord
  scope :published_on, ->(date) {
    where(created_at: date.beginning_of_day..date.end_of_day)
  }

  scope :last_batch_published, -> {
    if (last_article = order(created_at: :desc).first)
      published_on(last_article.created_at.to_date)
    else
      none
    end
  }
end
