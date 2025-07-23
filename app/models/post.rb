class Post < ApplicationRecord
  include ProfanityFilter

  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true, length: { minimum: 10, maximum: 1000 }
  belongs_to :user # This is the author
  has_many :comments, dependent: :destroy
  has_many :notifications, through: :user, dependent: :destroy
  has_many :notification_mentions, through: :user, dependent: :destroy
  has_noticed_notifications model_name: 'Noticed::Notification'
  validate :no_curse_words

  scope :published, -> { where.not(published_at: nil) }
  scope :draft, -> { where(published_at: nil) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[title body user_id published_at] # Allow searching by title, body, user_id and published_at
  end

  def self.ransackable_associations(_auth_object = nil)
    ["user", "comments"]
  end
end
