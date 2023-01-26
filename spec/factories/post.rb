FactoryBot.define do
  factory :post do
    association :end_user
    title { Faker::Lorem.characters(number: 10) }
    caption { Faker::Lorem.characters(number: 20) }
    address { Faker::Lorem.characters(number: 5) }
    latitude { Faker::Lorem.characters(number: 10) }
    longitude { Faker::Lorem.characters(number: 10) }
  end
end
