FactoryBot.define do
  factory :feature_group do
    name { Faker::Lorem.unique.word }
  end
end