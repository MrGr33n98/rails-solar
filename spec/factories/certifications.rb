FactoryBot.define do
  factory :certification do
    association :company
    name { Faker::Educator.course_name }
    issued_by { Faker::Company.name }
    issued_at { Faker::Date.backward(days: 365) }
    expires_at { Faker::Date.forward(days: 365) }
  end
end