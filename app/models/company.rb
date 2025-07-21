class Company < ApplicationRecord
  has_one_attached :logo
  belongs_to :user
  has_many   :certifications, dependent: :destroy
  has_many   :reviews,        dependent: :destroy
  has_many   :quotes,         dependent: :destroy

  # include Geocodable # Placeholder for geocoding concern

  enum target_segment: { residential: 0, commercial: 1, industrial: 2, public_sector: 3 }

  validates :name, :description, :location, :target_segment, presence: true

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id name description verified target_segment annual_energy_output installation_count user_id created_at updated_at]
    super + authorizable_ransackable_attributes
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "certifications", "reviews", "quotes"]
  end
end