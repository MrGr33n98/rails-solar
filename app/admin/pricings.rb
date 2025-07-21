ActiveAdmin.register Pricing do

  permit_params :product_id, :title, :currency, :value, :charge_type, :frequency, :payment_methods, :position, :state

  index do
    selectable_column
    id_column
    column :product
    column :title
    column :value
    column :currency
    column :frequency
    column :state
    column :position
    column :created_at
    actions
  end

  filter :product
  filter :currency
  filter :state
  filter :created_at

  form do |f|
    f.inputs do
      f.input :product
      f.input :title
      f.input :currency
      f.input :value
      f.input :charge_type
      f.input :frequency
      f.input :payment_methods
      f.input :position
      f.input :state
    end
    f.actions
  end

  show do
    attributes_table do
      row :product
      row :title
      row :currency
      row :value
      row :charge_type
      row :frequency
      row :payment_methods
      row :position
      row :state
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
