class SaasPlanSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :saas_product_id,
             :tier,
             :features,
             :price,
             :active,
             :created_at,
             :updated_at

  belongs_to :saas_product
end