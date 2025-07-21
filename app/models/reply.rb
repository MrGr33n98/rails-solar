class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :discussion

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :body, presence: true, length: { minimum: 5 }

  # after_create :notify_discussion_author # Placeholder for notification callback

  def self.ransackable_associations(auth_object = nil)
    ["user", "discussion"]
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id user_id discussion_id body status created_at updated_at]
    super + authorizable_ransackable_attributes
  end

  # private

  # def notify_discussion_author
  #   # Logic to notify the discussion author about the new reply
  # end
end
