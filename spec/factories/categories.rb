FactoryBot.define do
  factory :category do
    name { Faker::Commerce.department }
    sequence(:slug) { |n| "#{Faker::Internet.slug(words: name)}-#{SecureRandom.hex(4)}" }
    description { Faker::Lorem.paragraph }
    active { true }
    seo_title { Faker::Lorem.sentence(word_count: 5) }
    seo_description { Faker::Lorem.paragraph(sentence_count: 2) }
    seo_keywords { Faker::Lorem.words(number: 5).join(', ') }
    canonical_url { Faker::Internet.url }
    meta_robots { "index, follow" }
    h1 { Faker::Commerce.product_name }
    intro_text { Faker::Lorem.paragraph }
    schema_markup { "<script type=\"application/ld+json\">{}<\/script>" }
    name_translations { { en: name, es: Faker::Commerce.department } }
    description_translations { { en: description, es: Faker::Lorem.paragraph } }

    trait :with_parent do
      association :parent, factory: :category
      sequence(:slug) { |n| "child-category-#{n}" }
    end
  end
end