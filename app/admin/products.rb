ActiveAdmin.register Product do

  # Scopes para as abas
  scope :all, default: true
  scope("Pending")   { |products| products.where(status: :pending) }
  scope("Approved")  { |products| products.where(status: :approved) }
  scope("Canceled")  { |products| products.where(status: :canceled) }

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
  filter :categories, as: :select, collection: -> { Category.all.map { |c| [c.name, c.id] } }
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
      f.input :category_id, as: :select, collection: -> { Category.all.map { |c| [c.name, c.id] } }
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
