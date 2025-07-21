class PricingSerializer < ActiveModel::Serializer
  attributes :id,
             :product_id,
             :title,
             :currency,
             :value,
             :charge_type,
             :frequency,
             :payment_methods,
             :position,
             :state,
             :created_at,
             :updated_at

  belongs_to :product
end