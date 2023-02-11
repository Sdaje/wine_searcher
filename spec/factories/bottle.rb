FactoryBot.define do
  factory :bottle do
    name { Faker::Beer.name }
    expert_rating { Faker::Number.number(digits: 2) }
    image_url { Faker::Internet.url }
  end
end
