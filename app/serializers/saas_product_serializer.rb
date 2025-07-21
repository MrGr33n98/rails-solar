ActiveAdmin.register SaaSProduct do
  # ...
end

class SaaSProduct < ApplicationRecord
  class SaasProductSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :description,
               :price,
               :billing_cycle,
               :features,
               :active,
               :created_at,
               :updated_at

    has_many :saas_plans
    has_many :saas_leads
  end
end
