ActiveAdmin.register SaasProduct do

  permit_params :name, :description, :price, :billing_cycle, :features, :active

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :billing_cycle
    column :active
    column :created_at
    actions
  end

  filter :name
  filter :price
  filter :billing_cycle
  filter :active
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :billing_cycle, as: :select, collection: %w[monthly annually one_time]
      f.input :features
      f.input :active
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :billing_cycle
      row :features
      row :active
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
