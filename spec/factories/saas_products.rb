FactoryBot.define do
  factory :saas_product do
    name { Faker::App.name + " SaaS" }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 50.0..500.0) }
    billing_cycle { ['monthly', 'annually', 'one_time'].sample }
    features { { reports: true, analytics: false }.to_json }
    active { true }
    status { ['active', 'beta', 'retired'].sample }
  end
end