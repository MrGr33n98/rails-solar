# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_07_22_061208) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.integer "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "assess_campaigns", force: :cascade do |t|
    t.integer "product_id", null: false
    t.string "title", null: false
    t.string "code", null: false
    t.integer "owner_id", null: false
    t.integer "goal", null: false
    t.integer "achieved"
    t.integer "shares"
    t.string "prize"
    t.datetime "starts_at", precision: nil, null: false
    t.datetime "ends_at", precision: nil, null: false
    t.integer "debutantes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["owner_id"], name: "index_assess_campaigns_on_owner_id"
    t.index ["product_id"], name: "index_assess_campaigns_on_product_id"
    t.index ["status"], name: "index_assess_campaigns_on_status"
  end

  create_table "audit_logs", force: :cascade do |t|
    t.string "auditable_type"
    t.integer "auditable_id"
    t.integer "user_id"
    t.string "action"
    t.text "audited_changes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.integer "parent_id"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "seo_title"
    t.text "seo_description"
    t.string "seo_keywords"
    t.string "canonical_url"
    t.string "meta_robots"
    t.string "h1"
    t.text "intro_text"
    t.text "schema_markup"
    t.text "name_translations"
    t.text "description_translations"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["slug", "parent_id"], name: "index_categories_on_slug_and_parent_id", unique: true
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "product_id", null: false
    t.index ["category_id", "product_id"], name: "index_categories_products_on_category_and_product", unique: true
    t.index ["product_id", "category_id"], name: "index_categories_products_on_product_and_category"
  end

  create_table "certifications", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "name", null: false
    t.string "issued_by", null: false
    t.date "issued_at", null: false
    t.date "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_certifications_on_company_id"
    t.index ["expires_at"], name: "index_certifications_on_expires_at"
    t.index ["issued_at"], name: "index_certifications_on_issued_at"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "user_id", null: false
    t.boolean "verified"
    t.integer "target_segment"
    t.decimal "annual_energy_output"
    t.integer "installation_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.index ["location"], name: "index_companies_on_location"
    t.index ["target_segment"], name: "index_companies_on_target_segment"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "title"
    t.string "short_description"
    t.string "tags"
    t.string "lp_url"
    t.string "format"
    t.string "level"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "seo_title"
    t.text "seo_description"
    t.string "seo_keywords"
    t.string "canonical_url"
    t.string "meta_robots"
    t.string "h1"
    t.text "intro_text"
    t.text "schema_markup"
    t.index ["format"], name: "index_contents_on_format"
    t.index ["level"], name: "index_contents_on_level"
    t.index ["lp_url"], name: "index_contents_on_lp_url"
    t.index ["tags"], name: "index_contents_on_tags"
  end

  create_table "discussions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "product_id", null: false
    t.integer "category_id", null: false
    t.string "subject"
    t.text "body"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_discussions_on_category_id"
    t.index ["product_id"], name: "index_discussions_on_product_id"
    t.index ["status"], name: "index_discussions_on_status"
    t.index ["subject"], name: "index_discussions_on_subject"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "feature_groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_feature_groups_on_name", unique: true
  end

  create_table "features", force: :cascade do |t|
    t.string "name", null: false
    t.integer "feature_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_group_id"], name: "index_features_on_feature_group_id"
    t.index ["name", "feature_group_id"], name: "index_features_on_name_and_feature_group_id", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "leads", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "product_id", null: false
    t.string "name"
    t.string "email"
    t.string "role"
    t.string "company_size"
    t.string "desired_category"
    t.string "funnel_stage"
    t.integer "score"
    t.datetime "sent_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "conversion_state", default: 0
    t.string "utm_campaign"
    t.string "utm_source"
    t.string "utm_medium"
    t.index "\"lead_source\"", name: "index_leads_on_lead_source"
    t.index ["conversion_state"], name: "index_leads_on_conversion_state"
    t.index ["email"], name: "index_leads_on_email"
    t.index ["funnel_stage"], name: "index_leads_on_funnel_stage"
    t.index ["product_id"], name: "index_leads_on_product_id"
    t.index ["user_id"], name: "index_leads_on_user_id"
  end

  create_table "marketing_campaigns", force: :cascade do |t|
    t.string "name", null: false
    t.integer "channel", null: false
    t.text "template", null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "utm_campaign"
    t.string "utm_source"
    t.string "utm_medium"
    t.index ["channel"], name: "index_marketing_campaigns_on_channel"
    t.index ["scheduled_at"], name: "index_marketing_campaigns_on_scheduled_at"
  end

  create_table "noticed_events", force: :cascade do |t|
    t.string "type"
    t.string "record_type"
    t.bigint "record_id"
    t.json "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notifications_count"
    t.index ["notifications_count"], name: "index_noticed_events_on_notifications_count"
    t.index ["record_type", "record_id"], name: "index_noticed_events_on_record"
    t.index ["type"], name: "index_noticed_events_on_type"
  end

  create_table "noticed_notifications", force: :cascade do |t|
    t.string "type"
    t.bigint "event_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.datetime "read_at", precision: nil
    t.datetime "seen_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_noticed_notifications_on_event_id"
    t.index ["read_at"], name: "index_noticed_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_noticed_notifications_on_recipient"
    t.index ["seen_at"], name: "index_noticed_notifications_on_seen_at"
    t.index ["type"], name: "index_noticed_notifications_on_type"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "views", default: 0
    t.integer "user_id", null: false
    t.datetime "published_at"
    t.index ["published_at"], name: "index_posts_on_published_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
    t.index ["views"], name: "index_posts_on_views"
  end

  create_table "pricing_rules", force: :cascade do |t|
    t.string "name", null: false
    t.text "condition", null: false
    t.decimal "discount_pct", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_pct"], name: "index_pricing_rules_on_discount_pct"
    t.index ["name"], name: "index_pricing_rules_on_name"
  end

  create_table "pricings", force: :cascade do |t|
    t.integer "product_id", null: false
    t.string "title", null: false
    t.string "currency", null: false
    t.decimal "value", null: false
    t.string "charge_type", null: false
    t.string "frequency", null: false
    t.text "payment_methods"
    t.integer "position"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charge_type"], name: "index_pricings_on_charge_type"
    t.index ["currency"], name: "index_pricings_on_currency"
    t.index ["frequency"], name: "index_pricings_on_frequency"
    t.index ["product_id"], name: "index_pricings_on_product_id"
    t.index ["state"], name: "index_pricings_on_state"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "seo_url"
    t.string "seo_title", null: false
    t.string "status", null: false
    t.string "kind", null: false
    t.date "premium_until"
    t.string "source"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "name_translations"
    t.text "description_translations"
    t.index ["country"], name: "index_products_on_country"
    t.index ["kind"], name: "index_products_on_kind"
    t.index ["seo_url"], name: "index_products_on_seo_url", unique: true
    t.index ["source"], name: "index_products_on_source"
    t.index ["status"], name: "index_products_on_status"
  end

  create_table "quotes", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.text "message", null: false
    t.integer "company_id", null: false
    t.integer "status", default: 0, null: false
    t.decimal "estimated_kwh"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_quotes_on_company_id"
    t.index ["email"], name: "index_quotes_on_email"
    t.index ["phone"], name: "index_quotes_on_phone"
    t.index ["status"], name: "index_quotes_on_status"
  end

  create_table "replies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "discussion_id", null: false
    t.text "body", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_replies_on_discussion_id"
    t.index ["status"], name: "index_replies_on_status"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.integer "rating", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.integer "status", default: 0, null: false
    t.boolean "cliente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_reviews_on_company_id"
    t.index ["rating"], name: "index_reviews_on_rating"
    t.index ["status"], name: "index_reviews_on_status"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "saa_s_leads", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.string "preferred_contact_time"
    t.string "contact_method"
    t.string "company_name"
    t.string "building_type"
    t.string "roof_type"
    t.decimal "available_roof_area", precision: 8, scale: 2
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "monthly_energy_consumption_kwh"
    t.string "budget_range"
    t.string "decision_timeline"
    t.string "current_energy_provider"
    t.integer "score", default: 0
    t.integer "status", default: 0, null: false
    t.text "pain_points"
    t.string "competitor_considered"
    t.string "lead_source"
    t.string "utm_campaign"
    t.string "utm_source"
    t.string "utm_medium"
    t.integer "saas_plan_id"
    t.boolean "b2b", default: false
    t.string "funnel_stage"
    t.boolean "site_visit_scheduled", default: false
    t.datetime "site_visit_date"
    t.datetime "converted_at"
    t.datetime "proposal_sent_at"
    t.datetime "follow_up_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["b2b"], name: "index_saa_s_leads_on_b2b"
    t.index ["email"], name: "index_saa_s_leads_on_email"
    t.index ["funnel_stage"], name: "index_saa_s_leads_on_funnel_stage"
    t.index ["lead_source"], name: "index_saa_s_leads_on_lead_source"
    t.index ["saas_plan_id"], name: "index_saa_s_leads_on_saas_plan_id"
    t.index ["score"], name: "index_saa_s_leads_on_score"
    t.index ["status"], name: "index_saa_s_leads_on_status"
  end

  create_table "saa_s_plans", force: :cascade do |t|
    t.string "name"
    t.integer "saas_product_id", null: false
    t.string "tier"
    t.text "features"
    t.decimal "price"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_saa_s_plans_on_active"
    t.index ["saas_product_id"], name: "index_saa_s_plans_on_saas_product_id"
    t.index ["tier"], name: "index_saa_s_plans_on_tier"
  end

  create_table "saa_s_products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.decimal "price", null: false
    t.string "billing_cycle", null: false
    t.text "features"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", null: false
    t.index ["active"], name: "index_saa_s_products_on_active"
    t.index ["status"], name: "index_saa_s_products_on_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "views", default: 0
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assess_campaigns", "products"
  add_foreign_key "assess_campaigns", "products"
  add_foreign_key "assess_campaigns", "users", column: "owner_id"
  add_foreign_key "assess_campaigns", "users", column: "owner_id"
  add_foreign_key "certifications", "companies"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "discussions", "products"
  add_foreign_key "discussions", "users"
  add_foreign_key "features", "feature_groups"
  add_foreign_key "leads", "products"
  add_foreign_key "leads", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "pricings", "products"
  add_foreign_key "quotes", "companies"
  add_foreign_key "replies", "discussions"
  add_foreign_key "replies", "users"
  add_foreign_key "reviews", "companies"
  add_foreign_key "reviews", "users"
  add_foreign_key "saa_s_leads", "saas_plans"
  add_foreign_key "saa_s_plans", "saas_products"
end
