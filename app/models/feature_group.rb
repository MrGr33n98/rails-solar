class FeatureGroup < ApplicationRecord
  has_many :features, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    ["features"]
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id name created_at updated_at]
    super + authorizable_ransackable_attributes
  end
end
