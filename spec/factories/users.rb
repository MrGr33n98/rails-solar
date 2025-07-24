FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    name { Faker::Name.name }
    views { Faker::Number.between(from: 0, to: 1000) }
    role { [:admin, :editor].sample }
  end
end