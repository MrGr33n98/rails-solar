class SaasPlan < ApplicationRecord
  self.table_name = 'saa_s_plans'
  belongs_to :saas_product

  enum tier: { basic: 0, standard: 1, premium: 2 }

  validates :name, :price, :tier, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validate :features_must_be_valid_json

  scope :by_tier, ->(tier) { where(tier: tier) }

  def self.ransackable_associations(auth_object = nil)
    ["saas_product"]
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id name saas_product_id tier features price active created_at updated_at]
    super + authorizable_ransackable_attributes
  end

  private

  def features_must_be_valid_json
    return if features.blank?

    begin
      JSON.parse(features)
    rescue JSON::ParserError
      errors.add(:features, "must be a valid JSON string")
    end
  end
end
