class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, editor: 1 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :quotes, dependent: :destroy
  has_many :leads, dependent: :destroy
  has_many :saas_leads, dependent: :destroy

  # By implementing this feature, users will be able to conveniently
  # associate and access all notifications directed towards them.
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: 'Noticed::Notification'
  # Whenever you have noticed events that have the record pointing to the user,
  # such as when a new user joins a team or any similar occurrences,
  # It's important to ensure that notifications mentioning us are accessible.
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  validates :email, uniqueness: { case_sensitive: false }
  validates :role, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name email role created_at updated_at] # Allow searching by name, email, and role
  end

  def self.ransackable_associations(_auth_object = nil)
    ["posts", "comments", "reviews", "quotes", "leads", "saas_leads"]
  end
end
