class Article < ApplicationRecord
  default_scope { where(published_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  def self.generate_article
    article=  Article.create!(
      title: Faker::Book.title,
      summary: Faker::Lorem.sentence,
      published_at: Time.now,
      content: Faker::Lorem.paragraph
    )

    Rails.logger.info("Generated Article: '#{article.title}' at #{Time.now}")
  end
end
