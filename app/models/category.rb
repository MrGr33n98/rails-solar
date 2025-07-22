class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', optional: true
  has_many   :children, class_name: 'Category', foreign_key: :parent_id, dependent: :nullify

  has_and_belongs_to_many :products
  has_one_attached :seo_image

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: :parent_id, message: 'must be unique within its level' }
  before_validation :generate_slug, on: :create

  serialize :name_translations, JSON
  serialize :description_translations, JSON

  def self.ransackable_associations(auth_object = nil)
    %w[parent children products]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name slug parent_id active created_at updated_at]
  end

  def self.active_categories
    Rails.cache.fetch("active_categories", expires_in: 12.hours) do
      where(active: true).to_a
    end
  end

  private

  def generate_slug
    self.slug = name.parameterize if name.present? && slug.blank?
  end
end