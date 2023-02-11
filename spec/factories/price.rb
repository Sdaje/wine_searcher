FactoryBot.define do
  factory :price do
    value { Faker::Number.number(digits: 3) }
    website { Faker::Internet.url }
  end
end
