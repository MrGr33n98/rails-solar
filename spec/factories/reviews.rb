FactoryBot.define do
  factory :review do
    association :user
    association :company
    rating { Faker::Number.between(from: 1, to: 5) }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    status { :pending }
    cliente { Faker::Boolean.boolean }
  end
end