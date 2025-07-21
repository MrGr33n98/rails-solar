class Category < ApplicationRecord
  has_ancestry

  has_and_belongs_to_many :products
  has_one_attached :seo_image

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: :ancestry, message: "must be unique within its level" }

  before_validation :generate_slug, on: :create

  # Use Procs to avoid database queries during app load (for ActiveAdmin compatibility)
  scope :roots, -> { where(ancestry: nil) } if table_exists?
  scope :leaves, -> { where.not(id: Category.has_children.select(:id)) } if table_exists?

  def self.ransackable_associations(auth_object = nil)
    ["parent", "children", "products"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name slug ancestry active depth created_at updated_at]
  end

  private

  def generate_slug
    self.slug = name.parameterize if name.present? && slug.blank?
  end
end