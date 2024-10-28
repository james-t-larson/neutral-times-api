FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    summary { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published_at { Time.zone.now }
  end
end
