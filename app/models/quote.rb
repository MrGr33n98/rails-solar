class Quote < ApplicationRecord
  belongs_to :company
  belongs_to :user, optional: true

  enum status: { pending: 0, responded: 1, closed: 2 }

  validates :name, :email, :phone, :message, presence: true

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id name email phone message status estimated_kwh created_at updated_at]
    super + authorizable_ransackable_attributes
  end

  def self.ransackable_associations(auth_object = nil)
    ["company", "user"]
  end
end