ActiveAdmin.register Content do

  permit_params :title, :short_description, :tags, :lp_url, :format, :level, :active

  index do
    selectable_column
    id_column
    column :title
    column :format
    column :level
    column :active
    column :created_at
    actions
  end

  filter :title
  filter :format
  filter :level
  filter :active
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :short_description
      f.input :tags
      f.input :lp_url
      f.input :format, as: :select, collection: %w[article video infographic podcast]
      f.input :level, as: :select, collection: %w[beginner intermediate advanced]
      f.input :active
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :short_description
      row :tags
      row :lp_url
      row :format
      row :level
      row :active
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
