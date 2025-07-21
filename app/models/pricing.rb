class Pricing < ApplicationRecord
  belongs_to :product

  validates :title, :currency, :value, :charge_type, :frequency, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0.01 }

  scope :active, -> { where(state: :active) } # Assuming a 'state' column for active/inactive
  scope :by_currency, ->(currency) { where(currency: currency) }

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id product_id title currency value charge_type frequency payment_methods position state created_at updated_at]
    super + authorizable_ransackable_attributes
  end

  def self.ransackable_associations(auth_object = nil)
    ["product"]
  end
end