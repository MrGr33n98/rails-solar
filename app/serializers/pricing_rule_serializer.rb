# app/serializers/pricing_rule_serializer.rb
class PricingRuleSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :condition,
             :discount_pct,
             :created_at,
             :updated_at
end
