class SaasLead < ApplicationRecord
  self.table_name = 'saa_s_leads'
  belongs_to :user
  belongs_to :saas_product

  enum status: { new_lead: 0, contacted: 1, qualified: 2, unqualified: 3, converted: 4 }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  validates :status, presence: true
  validates :contacted_at, presence: true, if: -> { contacted? || qualified? || unqualified? || converted? }

  scope :recent_leads, -> { order(created_at: :desc).limit(10) }

  def self.ransackable_associations(auth_object = nil)
    ["user", "saas_product"]
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id user_id saas_product_id company email phone status contacted_at created_at updated_at]
    super + authorizable_ransackable_attributes
  end
end