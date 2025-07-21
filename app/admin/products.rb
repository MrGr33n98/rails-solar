ActiveAdmin.register Product do

  permit_params :name, :seo_url, :seo_title, :status, :kind, :premium_until, :source, :country, category_ids: []

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
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
