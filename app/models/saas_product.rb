class SaasProduct < ApplicationRecord
  self.table_name = 'saa_s_products'
  has_many :saas_plans
  has_many :saas_leads

  validates :name, :description, :price, :billing_cycle, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :billing_cycle, inclusion: { in: %w[monthly annually one_time], message: "%<value>s is not a valid billing cycle" }

  scope :active_products, -> { where(active: true) }

  def self.ransackable_associations(auth_object = nil)
    ["saas_plans", "saas_leads"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description price billing_cycle features active status created_at updated_at]
  end
end
