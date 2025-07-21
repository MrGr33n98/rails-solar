ActiveAdmin.register AssessCampaign do

  permit_params :product_id, :title, :code, :owner_id, :goal, :achieved, :shares, :prize, :starts_at, :ends_at, :debutantes, :status

  index do
    selectable_column
    id_column
    column :title
    column :product
    column :owner
    column :goal
    column :achieved
    column :shares
    column :prize
    column :starts_at
    column :ends_at
    column :status do |campaign|
      campaign.status.humanize
    end
    column :created_at
    actions
  end

  filter :title
  filter :product
  filter :owner
  filter :status, as: :select, collection: AssessCampaign.statuses.keys.map { |k| [k.humanize, k] }
  filter :starts_at
  filter :ends_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :product
      f.input :owner
      f.input :title
      f.input :code
      f.input :goal
      f.input :achieved
      f.input :shares
      f.input :prize
      f.input :starts_at, as: :datepicker
      f.input :ends_at, as: :datepicker
      f.input :debutantes
      f.input :status, as: :select, collection: AssessCampaign.statuses.keys.map { |k| [k.humanize, k] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :product
      row :owner
      row :title
      row :code
      row :goal
      row :achieved
      row :shares
      row :prize
      row :starts_at
      row :ends_at
      row :debutantes
      row :status do |campaign|
        campaign.status.humanize
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
