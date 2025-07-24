FactoryBot.define do
  factory :discussion do
    association :user
    association :product
    association :category
    subject { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    status { :open }
  end
end