FactoryBot.define do
  factory :content do
    sub_title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraphs(number: 5).join("\n\n") }
    association :story
  end
end
