FactoryBot.define do
  factory :post_tag do
    association :tag
    association :post
  end
end