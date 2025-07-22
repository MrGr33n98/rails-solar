class Product < ApplicationRecord
  has_many_attached :images
  has_and_belongs_to_many :categories
  has_many :feature_groups, dependent: :destroy

  validates :name, :status, :kind, presence: true
  validates :seo_url, uniqueness: true, allow_blank: true
  validates :seo_title, presence: true, length: { maximum: 60 }, allow_blank: true

  before_validation :generate_seo_url, on: :create

  serialize :name_translations, JSON
  serialize :description_translations, JSON

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id name seo_url seo_title status kind premium_until source country created_at updated_at]
    super + authorizable_ransackable_attributes
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "feature_groups"]
  end

  def self.active_products
    Rails.cache.fetch("active_products", expires_in: 12.hours) do
      where(status: :active).to_a # Assuming 'active' is a valid status for products
    end
  end

  private

  def generate_seo_url
    self.seo_url = name.parameterize if name.present? && seo_url.blank?
  end
end