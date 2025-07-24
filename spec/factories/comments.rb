FactoryBot.define do
  factory :comment do
    association :post
    association :user
    body { Faker::Lorem.paragraph }
    status { :pending }
  end
end