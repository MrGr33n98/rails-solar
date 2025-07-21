class Lead < ApplicationRecord
  belongs_to :user
  belongs_to :product

  enum conversion_state: { new_lead: 0, contacted: 1, qualified: 2, unqualified: 3, converted: 4 }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true
  validates :conversion_state, presence: true

  scope :qualified, -> { where(conversion_state: :qualified) }

  def self.ransackable_associations(auth_object = nil)
    ["user", "product"]
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id user_id product_id name email role company_size desired_category funnel_stage score sent_at created_at updated_at conversion_state]
    super + authorizable_ransackable_attributes
  end
end