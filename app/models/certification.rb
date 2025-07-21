class Certification < ApplicationRecord
  belongs_to :company

  validates :name, :issued_by, :issued_at, :expires_at, presence: true
  validate :issued_at_before_expires_at

  # include Notifiable # Placeholder for a notification concern

  def self.ransackable_associations(auth_object = nil)
    ["company"]
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id company_id name issued_by issued_at expires_at created_at updated_at]
    super + authorizable_ransackable_attributes
  end

  private

  def issued_at_before_expires_at
    return if issued_at.blank? || expires_at.blank?

    if issued_at >= expires_at
      errors.add(:issued_at, "must be before expires_at")
    end
  end
end