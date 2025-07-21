ActiveAdmin.register Company do

  permit_params :name, :description, :user_id, :verified, :target_segment, :annual_energy_output, :installation_count, :location

  index do
    selectable_column
    id_column
    column :name
    column :user
    column :verified
    column :target_segment do |company|
      company.target_segment.humanize
    end
    column :annual_energy_output
    column :installation_count
    column :created_at
    actions
  end

  filter :name
  filter :verified
  filter :target_segment, as: :select, collection: Company.target_segments.keys.map { |k| [k.humanize, k] }
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :name
      f.input :description
      f.input :verified
      f.input :target_segment, as: :select, collection: Company.target_segments.keys.map { |k| [k.humanize, k] }
      f.input :annual_energy_output
      f.input :installation_count
      f.input :location # Assuming this is a string field for address
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :name
      row :description
      row :verified
      row :target_segment do |company|
        company.target_segment.humanize
      end
      row :annual_energy_output
      row :installation_count
      row :location
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
