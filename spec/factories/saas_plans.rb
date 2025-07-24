FactoryBot.define do
  factory :saas_plan do
    association :saas_product
    name { Faker::Commerce.product_name + " Plan" }
    tier { [:basic, :standard, :premium].sample }
    features { { storage: "100GB", users: 10 }.to_json }
    price { Faker::Commerce.price(range: 10.0..100.0) }
    active { true }
  end
end