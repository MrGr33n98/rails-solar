class MarketingCampaign < ApplicationRecord
  enum channel: { email: 0, sms: 1, push: 2 }

  validates :name, :channel, :template, :scheduled_at, presence: true
  validate :scheduled_at_in_future

  scope :upcoming, -> { where('scheduled_at > ?', Time.current) }
  scope :past, -> { where('scheduled_at <= ?', Time.current) }

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id name channel template scheduled_at created_at updated_at]
    super + authorizable_ransackable_attributes
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private

  def scheduled_at_in_future
    return if scheduled_at.blank?

    if scheduled_at <= Time.current
      errors.add(:scheduled_at, "must be in the future")
    end
  end
end