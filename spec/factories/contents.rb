FactoryBot.define do
  factory :content do
    title { Faker::Lorem.sentence }
    short_description { Faker::Lorem.paragraph_by_chars(number: 150) }
    tags { Faker::Lorem.words(number: 3).join(', ') }
    lp_url { Faker::Internet.url }
    format { [:article, :video, :infographic, :podcast].sample }
    level { [:beginner, :intermediate, :advanced].sample }
    active { true }
    seo_title { Faker::Lorem.sentence(word_count: 5) }
    seo_description { Faker::Lorem.paragraph(sentence_count: 2) }
    seo_keywords { Faker::Lorem.words(number: 5).join(', ') }
    canonical_url { Faker::Internet.url }
    meta_robots { "index, follow" }
    h1 { Faker::Commerce.product_name }
    intro_text { Faker::Lorem.paragraph }
    schema_markup { "<script type=\"application/ld+json\">{}<\/script>" }
  end
end