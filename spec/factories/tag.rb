FactoryBot.define do
  factory :tag do
    category { [1, 2].sample }
    value { Faker::Lorem.word }
  end
end
