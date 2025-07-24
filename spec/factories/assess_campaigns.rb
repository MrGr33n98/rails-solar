FactoryBot.define do
  factory :assess_campaign do
    association :product
    association :owner, factory: :user
    title { Faker::Lorem.sentence }
    code { Faker::Alphanumeric.unique.alphanumeric(number: 10) }
    goal { Faker::Number.between(from: 100, to: 1000) }
    achieved { Faker::Number.between(from: 0, to: 99) }
    shares { Faker::Number.between(from: 0, to: 500) }
    prize { Faker::Commerce.product_name }
    starts_at { Faker::Time.between(from: DateTime.now - 7, to: DateTime.now) }
    ends_at { Faker::Time.between(from: DateTime.now, to: DateTime.now + 7) }
    debutantes { Faker::Number.between(from: 0, to: 100) }
    status { :active }
  end
end