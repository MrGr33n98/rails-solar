ActiveAdmin.register Certification do

  permit_params :company_id, :name, :issued_by, :issued_at, :expires_at

  index do
    selectable_column
    id_column
    column :name
    column :company
    column :issued_by
    column :issued_at
    column :expires_at
    column :created_at
    actions
  end

  filter :company
  filter :name
  filter :issued_by
  filter :issued_at
  filter :expires_at
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :company
      f.input :name
      f.input :issued_by
      f.input :issued_at, as: :datepicker
      f.input :expires_at, as: :datepicker
    end
    f.actions
  end

  show do
    attributes_table do
      row :company
      row :name
      row :issued_by
      row :issued_at
      row :expires_at
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
