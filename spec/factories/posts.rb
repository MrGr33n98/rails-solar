FactoryBot.define do
  factory :post do
    association :user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    views { Faker::Number.between(from: 0, to: 1000) }
    published_at { Faker::Time.between(from: DateTime.now - 30, to: DateTime.now) }
  end
end