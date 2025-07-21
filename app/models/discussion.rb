class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :category

  enum status: { open: 0, closed: 1, archived: 2 }

  validates :subject, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :status, presence: true

  scope :recent, -> { order(created_at: :desc).limit(10) }

  def self.ransackable_associations(auth_object = nil)
    ["user", "product", "category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id user_id product_id category_id subject body status created_at updated_at]
    super + authorizable_ransackable_attributes
  end
end
