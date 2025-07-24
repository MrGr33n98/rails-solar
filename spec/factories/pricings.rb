FactoryBot.define do
  factory :pricing do
    association :product
    title { Faker::Commerce.product_name }
    currency { Faker::Currency.code }
    value { Faker::Commerce.price(range: 100.0..1000.0) }
    charge_type { ['one_time', 'recurring'].sample }
    frequency { ['monthly', 'annually', 'quarterly'].sample }
    payment_methods { ['credit_card', 'paypal', 'bank_transfer'].sample(2).to_json }
    position { Faker::Number.between(from: 1, to: 10) }
    state { ['active', 'inactive'].sample }
  end
end