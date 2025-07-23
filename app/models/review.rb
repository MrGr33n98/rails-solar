class Review < ApplicationRecord
  belongs_to :user
  belongs_to :company

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :rating, inclusion: { in: 1..5 }
  validates :title, :content, presence: true

  scope :top_rated, -> { where('rating >= ?', 4).order(rating: :desc) } # Example: top_rated are reviews with 4 or 5 stars

  # after_create :notify_company_about_review # Placeholder for notification callback

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id rating title content status created_at updated_at user_id company_id]
    super + authorizable_ransackable_attributes
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "company"]
  end

  # private

  # def notify_company_about_review
  #   # Logic to notify the company about a new review
  # end
end