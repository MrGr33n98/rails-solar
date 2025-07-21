class SaasLeadSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :saas_product_id,
             :company,
             :email,
             :phone,
             :status,
             :contacted_at,
             :created_at,
             :updated_at

  belongs_to :user
  belongs_to :saas_product
end