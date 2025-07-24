FactoryBot.define do
  factory :quote do
    association :company
    association :user, factory: :user, strategy: :build
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    message { Faker::Lorem.paragraph }
    status { :pending }
    estimated_kwh { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
  end
end