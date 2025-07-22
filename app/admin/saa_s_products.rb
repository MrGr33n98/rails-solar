ActiveAdmin.register SaasProduct do

  permit_params :name, :description, :price, :billing_cycle, :features, :active, :status

  # Scopes para as abas
  scope("Aguardando aprovação") { |products| products.where(status: 'pending') }
  scope("Aprovadas")            { |products| products.where(status: 'approved') }
  scope("Canceladas")           { |products| products.where(status: 'canceled') }

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :billing_cycle
    column :active
    column :status
    column :created_at
    actions
  end

  filter :name
  filter :price
  filter :billing_cycle
  filter :active
  filter :status
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :billing_cycle, as: :select, collection: %w[monthly annually one_time]
      f.input :features
      f.input :active
      f.input :status, as: :select, collection: %w[pending approved canceled]
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
      row :status
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
