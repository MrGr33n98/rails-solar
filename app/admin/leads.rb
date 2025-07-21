ActiveAdmin.register Lead do

  permit_params :user_id, :product_id, :name, :email, :role, :company_size, :desired_category, :funnel_stage, :score, :sent_at, :conversion_state

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :user
    column :product
    column :funnel_stage
    column :score
    column :conversion_state do |lead|
      lead.conversion_state.humanize
    end
    column :sent_at
    column :created_at
    actions
  end

  filter :email
  filter :funnel_stage
  filter :conversion_state, as: :select, collection: Lead.conversion_states.keys.map { |k| [k.humanize, k] }
  filter :user
  filter :product
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :product
      f.input :name
      f.input :email
      f.input :role
      f.input :company_size
      f.input :desired_category
      f.input :funnel_stage
      f.input :score
      f.input :sent_at, as: :datepicker
      f.input :conversion_state, as: :select, collection: Lead.conversion_states.keys.map { |k| [k.humanize, k] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :product
      row :name
      row :email
      row :role
      row :company_size
      row :desired_category
      row :funnel_stage
      row :score
      row :conversion_state do |lead|
        lead.conversion_state.humanize
      end
      row :sent_at
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item :mark_as_qualified, only: :show do
    link_to 'Mark as Qualified', mark_as_qualified_admin_lead_path(lead), method: :put unless lead.qualified?
  end

  member_action :mark_as_qualified, method: :put do
    lead = Lead.find(params[:id])
    lead.qualified!
    redirect_to admin_lead_path(lead), notice: "Lead marked as qualified!"
  end

end
