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
      lead.conversion_state.present? ? lead.conversion_state.humanize : "-"
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
        lead.conversion_state.present? ? lead.conversion_state.humanize : "-"
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

ActiveAdmin.register SaasLead do
  permit_params :first_name, :last_name, :email, :phone_number, :preferred_contact_time, :contact_method,
                :company_name, :building_type, :roof_type, :available_roof_area, :address, :city, :state,
                :monthly_energy_consumption_kwh, :budget_range, :decision_timeline, :current_energy_provider,
                :score, :status, :pain_points, :competitor_considered, :lead_source, :utm_campaign, :utm_source,
                :utm_medium, :saas_plan_id, :b2b, :funnel_stage, :site_visit_scheduled, :site_visit_date,
                :converted_at, :proposal_sent_at, :follow_up_date

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :company_name
    column :lead_source
    column :status
    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :company_name
  filter :lead_source
  filter :status
  filter :created_at

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone_number
      f.input :preferred_contact_time
      f.input :contact_method
      f.input :company_name
      f.input :building_type
      f.input :roof_type
      f.input :available_roof_area
      f.input :address
      f.input :city
      f.input :state
      f.input :monthly_energy_consumption_kwh
      f.input :budget_range
      f.input :decision_timeline
      f.input :current_energy_provider
      f.input :score
      f.input :status, as: :select, collection: SaasLead.statuses.keys
      f.input :pain_points
      f.input :competitor_considered
      f.input :lead_source
      f.input :utm_campaign
      f.input :utm_source
      f.input :utm_medium
      f.input :saas_plan
      f.input :b2b
      f.input :funnel_stage
      f.input :site_visit_scheduled
      f.input :site_visit_date, as: :datepicker
      f.input :converted_at, as: :datepicker
      f.input :proposal_sent_at, as: :datepicker
      f.input :follow_up_date, as: :datepicker
    end
    f.actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone_number
      row :preferred_contact_time
      row :contact_method
      row :company_name
      row :building_type
      row :roof_type
      row :available_roof_area
      row :address
      row :city
      row :state
      row :monthly_energy_consumption_kwh
      row :budget_range
      row :decision_timeline
      row :current_energy_provider
      row :score
      row :status
      row :pain_points
      row :competitor_considered
      row :lead_source
      row :utm_campaign
      row :utm_source
      row :utm_medium
      row :saas_plan
      row :b2b
      row :funnel_stage
      row :site_visit_scheduled
      row :site_visit_date
      row :converted_at
      row :proposal_sent_at
      row :follow_up_date
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
