FactoryBot.define do
  factory :story do
    title { Faker::Book.title }
    summary { Faker::Lorem.sentence }
    published_at { Time.zone.now }

    transient do
      contents_count { 3 }
    end

    after(:create) do |story, evaluator|
      create_list(:content, evaluator.contents_count, story: story)
    end
  end
end
