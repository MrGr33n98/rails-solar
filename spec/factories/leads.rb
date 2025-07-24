FactoryBot.define do
  factory :lead do
    association :user
    association :product
    name { Faker::Name.name }
    email { Faker::Internet.email }
    role { Faker::Job.title }
    company_size { ['1-10', '11-50', '51-200', '201-500', '500+'].sample }
    desired_category { Faker::Commerce.department }
    funnel_stage { ['awareness', 'consideration', 'decision'].sample }
    score { Faker::Number.between(from: 1, to: 100) }
    sent_at { Faker::Time.between(from: DateTime.now - 30, to: DateTime.now) }
    conversion_state { [:new_lead, :contacted, :qualified, :unqualified, :converted].sample }
    utm_campaign { Faker::Lorem.word }
    utm_source { Faker::Internet.domain_word }
    utm_medium { ['email', 'social', 'cpc'].sample }
  end
end