class SaasLead < ApplicationRecord
  self.table_name = 'saa_s_leads'
  belongs_to :user
  belongs_to :saas_product
  belongs_to :saas_plan, optional: true

  enum status: {
    new_lead:       0,
    contacted:      1,
    proposal_sent:  2,
    won:            3,
    lost:           4
  }

  validates :first_name, :last_name, :email, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  validates :status, presence: true
  validates :contacted_at, presence: true, if: -> { contacted? || qualified? || unqualified? || converted? }

  scope :recent_leads, -> { order(created_at: :desc).limit(10) }

  def self.ransackable_associations(auth_object = nil)
    ["user", "saas_product", "saas_plan"]
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id user_id saas_product_id company email phone status contacted_at created_at updated_at]
    super + authorizable_ransackable_attributes + %w[
      first_name last_name email phone_number preferred_contact_time contact_method
      company_name building_type roof_type available_roof_area address city state
      monthly_energy_consumption_kwh budget_range decision_timeline current_energy_provider
      score status pain_points competitor_considered lead_source utm_campaign utm_source utm_medium
      saas_plan_id b2b funnel_stage site_visit_scheduled site_visit_date converted_at
      proposal_sent_at follow_up_date created_at updated_at
    ]
  end
end