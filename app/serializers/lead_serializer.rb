class LeadSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :product_id,
             :name,
             :email,
             :role,
             :company_size,
             :desired_category,
             :funnel_stage,
             :score,
             :sent_at,
             :created_at,
             :updated_at

  belongs_to :user
  belongs_to :product
end