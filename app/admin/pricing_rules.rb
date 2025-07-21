ActiveAdmin.register PricingRule do

  permit_params :name, :condition, :discount_pct

  index do
    selectable_column
    id_column
    column :name
    column :condition
    column :discount_pct
    column :created_at
    actions
  end

  filter :name
  filter :discount_pct
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :condition
      f.input :discount_pct
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :condition
      row :discount_pct
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
