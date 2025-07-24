FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    seo_url { Faker::Internet.slug(words: name) }
    seo_title { Faker::Lorem.sentence(word_count: 5) }
    status { ['active', 'inactive', 'draft'].sample }
    kind { ['service', 'good'].sample }
    premium_until { Faker::Date.forward(days: 365) }
    source { Faker::Company.name }
    country { Faker::Address.country_code }
    name_translations { { en: name, es: Faker::Commerce.product_name } }
    description_translations { { en: Faker::Lorem.paragraph, es: Faker::Lorem.paragraph } }
  end
end