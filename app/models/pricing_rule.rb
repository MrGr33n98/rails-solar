class PricingRule < ApplicationRecord
  validates :name, :condition, :discount_pct, presence: true
  validates :discount_pct, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :condition, format: { with: /\A[a-zA-Z0-9_\s\.\+\-\*\/\(\)\[\]\=\!\&\|\<\>\"\\]+\z/, message: "contains invalid characters or format" }

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id name condition discount_pct created_at updated_at]
    super + authorizable_ransackable_attributes
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end