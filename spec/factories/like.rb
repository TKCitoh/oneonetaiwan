FactoryBot.define do
  factory :like do
    association :end_user
    association :post
  end
end