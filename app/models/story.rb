class Story < ApplicationRecord
  has_many :contents, dependent: :destroy
  accepts_nested_attributes_for :contents, allow_destroy: true

  default_scope { where(published_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  def self.generate_story
    story = Story.create!(
      title: Faker::Book.title,
      summary: Faker::Lorem.sentence,
      published_at: Time.now
    )

    3.times do
      story.contents.create!(
        sub_title: Faker::Lorem.sentence,
        text: Faker::Lorem.paragraphs(number: 5)
      )
    end

    Rails.logger.info("Generated Story: '#{story.title}' at #{Time.now}")
  end
end
