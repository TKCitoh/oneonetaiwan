FactoryBot.define do
  factory :end_user do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number:6) }
    name { Faker::Name.characters(number:5) }
  end
end