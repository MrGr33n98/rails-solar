# Conteúdo dos arquivos principais

## app/admin/categories.rb
```ruby
ActiveAdmin.register Category do
  permit_params :name, :slug, :description, :parent_id, :active, :depth,
    :seo_title, :seo_description, :seo_keywords, :canonical_url, :meta_robots, :h1, :intro_text, :schema_markup, :seo_image

  index do
    selectable_column
    id_column
    column :name
    column :slug
    column("Parent") { |category| category.parent&.name }
    column :active
    column :depth
    column :created_at
    actions
  end

  filter :name
  filter :slug
  # filter :parent, as: :select, collection: Category.all.map { |c| [c.name, c.id] }
  filter :ancestry, as: :select, collection: proc { Category.all.map { |c| [c.name, c.ancestry] } }
  filter :active
  filter :created_at
  filter :ancestry, as: :select, collection: proc { Category.roots.map { |c| [c.name, c.id] } }

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
      f.input :description
      f.input :parent_id, as: :select, collection: Category.all.map { |c| [c.name, c.id] }, include_blank: true
      f.input :active
      f.input :depth
      f.input :seo_title
      f.input :seo_description
      f.input :seo_keywords
      f.input :canonical_url
      f.input :meta_robots, as: :select, collection: ['index, follow', 'noindex, follow', 'index, nofollow', 'noindex, nofollow']
      f.input :h1
      f.input :intro_text
      f.input :schema_markup
      f.input :seo_image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :slug
      row :description
      row("Parent") { |category| category.parent&.name }
      row :active
      row :depth
      row :seo_title
      row :seo_description
      row :seo_keywords
      row :canonical_url
      row :meta_robots
      row :h1
      row :intro_text
      row :schema_markup
      row :seo_image do |category|
        if category.seo_image.attached?
          image_tag helpers.rails_blob_url(category.seo_image), width: 200
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
```

## app/admin/companies.rb
```ruby
ActiveAdmin.register Company do
  permit_params :name, :description, :user_id, :verified, :target_segment, :annual_energy_output, :installation_count, :location, :logo
  index do
    selectable_column
    id_column
    column :name
    column :user
    column :verified
    column :target_segment do |company|
      company.target_segment.humanize
    end
    column :annual_energy_output
    column :installation_count
    column :logo do |company|
      if company.logo.attached?
        image_tag helpers.rails_blob_url(company.logo), width: 50
      end
    end
    column :created_at
    actions
  end
  filter :name
  filter :verified
  filter :target_segment, as: :select, collection: Company.target_segments.keys.map { |k| [k.humanize, k] }
  filter :created_at
  form do |f|
    f.inputs do
      f.input :user
      f.input :name
      f.input :description
      f.input :verified
      f.input :target_segment, as: :select, collection: Company.target_segments.keys.map { |k| [k.humanize, k] }
      f.input :annual_energy_output
      f.input :installation_count
      f.input :location
      f.input :logo, as: :file
    end
    f.actions
  end
  show do
    attributes_table do
      row :user
      row :name
      row :description
      row :verified
      row :target_segment do |company|
        company.target_segment.humanize
      end
      row :annual_energy_output
      row :installation_count
      row :location
      row :logo do |company|
        if company.logo.attached?
          image_tag helpers.rails_blob_url(company.logo), width: 200
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
```

## app/admin/products.rb
```ruby
ActiveAdmin.register Product do
  permit_params :name, :seo_url, :seo_title, :status, :kind, :premium_until, :source, :country, category_ids: [], images: []
  index do
    selectable_column
    id_column
    column :name
    column :status
    column :kind
    column :seo_url
    column :seo_title
    column :premium_until
    column :source
    column :country
    column :images do |product|
      if product.images.attached?
        product.images.map do |img|
          image_tag helpers.rails_blob_url(img), width: 50
        end.join(' ').html_safe
      end
    end
    column :created_at
    actions
  end
  filter :name
  filter :status
  filter :kind
  filter :categories
  filter :created_at
  form do |f|
    f.inputs do
      f.input :name
      f.input :status
      f.input :kind
      f.input :seo_url
      f.input :seo_title
      f.input :premium_until, as: :datepicker
      f.input :source
      f.input :country, as: :select, collection: ISO3166::Country.all.map { |c| [c.translations[I18n.locale.to_s] || c.name, c.alpha2] }
      f.input :categories, as: :check_boxes
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end
  show do
    attributes_table do
      row :name
      row :status
      row :kind
      row :seo_url
      row :seo_title
      row :premium_until
      row :source
      row :country
      row :categories do |product|
        product.categories.map(&:name).join(", ")
      end
      row :images do |product|
        if product.images.attached?
          product.images.map do |img|
            image_tag helpers.rails_blob_url(img), width: 100
          end.join(' ').html_safe
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
```

## app/controllers/api/v1/categories_controller.rb
```ruby
module Api
  module V1
    class CategoriesController < ApplicationController
      # GET /api/v1/categories
      def index
        # Returns only root categories with their children loaded
        categories = Category.includes(:children).where(parent_id: nil)
        render json: categories, each_serializer: CategorySerializer
      end
      # GET /api/v1/categories/:id
      def show
        category = Category.find(params[:id])
        # Includes subcategories in the response
        render json: category, serializer: CategorySerializer
      end
    end
  end
end
```

## app/controllers/api/v1/companies_controller.rb
```ruby
module Api
  module V1
    class CompaniesController < ApplicationController
      # GET /api/v1/companies
      def index
        companies = Company.all
        render json: companies, each_serializer: CompanySerializer
      end
      # GET /api/v1/companies/:id
      def show
        company = Company.find(params[:id])
        render json: company, serializer: CompanySerializer
      end
    end
  end
end
```

## app/models/category.rb
```ruby
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
```

## app/models/company.rb
```ruby
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
```

## app/models/product.rb
```ruby
class Product < ApplicationRecord
  has_many_attached :images
  has_and_belongs_to_many :categories
  has_many :feature_groups, dependent: :destroy
  validates :name, :status, :kind, presence: true
  validates :seo_url, uniqueness: true, allow_blank: true
  validates :seo_title, presence: true, length: { maximum: 60 }, allow_blank: true
  before_validation :generate_seo_url, on: :create
  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id name seo_url seo_title status kind premium_until source country created_at updated_at]
    super + authorizable_ransackable_attributes
  end
  def self.ransackable_associations(auth_object = nil)
    ["categories", "feature_groups"]
  end
  private
  def generate_seo_url
    self.seo_url = name.parameterize if name.present? && seo_url.blank?
  end
end
```
