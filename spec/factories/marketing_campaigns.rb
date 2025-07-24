FactoryBot.define do
  factory :marketing_campaign do
    name { Faker::Lorem.sentence(word_count: 3) }
    channel { [:email, :sms, :push].sample }
    template { Faker::Lorem.paragraph }
    scheduled_at { Faker::Time.forward(days: 30) }
    utm_campaign { Faker::Lorem.word }
    utm_source { Faker::Internet.domain_word }
    utm_medium { ['email', 'social', 'cpc'].sample }
  end
end