FactoryBot.define do
  factory :company do
    association :user
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    location { Faker::Address.city }
    verified { Faker::Boolean.boolean }
    target_segment { [:residential, :commercial, :industrial, :public_sector].sample }
    annual_energy_output { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    installation_count { Faker::Number.between(from: 1, to: 100) }
  end
end