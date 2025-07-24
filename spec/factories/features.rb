FactoryBot.define do
  factory :feature do
    association :feature_group
    name { Faker::Lorem.unique.word }
  end
end