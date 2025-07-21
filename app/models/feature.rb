class Feature < ApplicationRecord
  belongs_to :feature_group

  validates :name, presence: true, uniqueness: { scope: :feature_group_id }

  def self.ransackable_associations(auth_object = nil)
    ["feature_group"]
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id name feature_group_id created_at updated_at]
    super + authorizable_ransackable_attributes
  end
end 