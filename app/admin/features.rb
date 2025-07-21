ActiveAdmin.register Feature do

  permit_params :name, :feature_group_id

  index do
    selectable_column
    id_column
    column :name
    column :feature_group
    column :created_at
    actions
  end

  filter :name
  filter :feature_group
  filter :created_at

  form do |f|
    f.inputs do
      f.input :feature_group
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :feature_group
      row :name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
