class AssessCampaign < ApplicationRecord
  belongs_to :product
  belongs_to :owner, class_name: 'User'

  enum status: { draft: 0, active: 1, completed: 2, cancelled: 3 }

  validates :title, :code, :goal, :starts_at, :ends_at, :status, presence: true
  validates :goal, numericality: { greater_than: 0 }
  validate :ends_at_after_starts_at

  scope :ongoing, -> { where('starts_at <= ? AND ends_at >= ?', Time.current, Time.current) }
  scope :completed, -> { where('ends_at < ?', Time.current) }

  def self.ransackable_attributes(auth_object = nil)
    %w[id title code goal achieved shares prize starts_at ends_at debutantes status created_at updated_at owner_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[owner product]
  end

  private

  def ends_at_after_starts_at
    return if ends_at.blank? || starts_at.blank?
    if ends_at < starts_at
      errors.add(:ends_at, 'cannot be before starts_at')
    end
  end
end