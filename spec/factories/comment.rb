FactoryBot.define do
  factory :comment do
    association :end_user
    association :post
    comment { Faker::Lorem.characters(number: 20) }
  end
end
