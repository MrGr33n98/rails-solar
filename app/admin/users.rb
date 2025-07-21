ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation, :name, :role, :phone, :banned_until, :is_super_admin

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :role do |user|
      user.role.humanize
    end
    column :is_super_admin
    column :banned_until
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :role, as: :select, collection: User.roles.keys.map { |k| [k.humanize, k] }
  filter :is_super_admin
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :role, as: :select, collection: User.roles.keys.map { |k| [k.humanize, k] }
      f.input :phone
      f.input :banned_until, as: :datepicker
      f.input :is_super_admin
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :role do |user|
        user.role.humanize
      end
      row :phone
      row :banned_until
      row :is_super_admin
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
