FactoryBot.define do
  factory :saas_lead do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    preferred_contact_time { "Morning" }
    contact_method { "Email" }
    company_name { Faker::Company.name }
    building_type { "Commercial" }
    roof_type { "Flat" }
    available_roof_area { 100.50 }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    monthly_energy_consumption_kwh { 1000 }
    budget_range { "$10,000 - $20,000" }
    decision_timeline { "3-6 months" }
    current_energy_provider { Faker::Company.name }
    score { 50 }
    status { :new_lead }
    pain_points { Faker::Lorem.paragraph }
    competitor_considered { Faker::Company.name }
    lead_source { "Website" }
    utm_campaign { "SummerSale" }
    utm_source { "Google" }
    utm_medium { "cpc" }
    association :saas_plan
    b2b { false }
    funnel_stage { "Awareness" }
    site_visit_scheduled { false }
    site_visit_date { nil }
    converted_at { nil }
    proposal_sent_at { nil }
    follow_up_date { nil }
  end
end