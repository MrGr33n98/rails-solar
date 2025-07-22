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
    column :status do |lead|
      lead.status.present? ? lead.status.humanize : "-"
    end
    column :created_at
    actions
  end

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
      f.input :status, as: :select, collection: SaasLead.statuses.keys.map { |k| [k.humanize, k] }
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

end