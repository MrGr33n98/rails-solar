ActiveAdmin.register SaasLead do

  permit_params :user_id, :saas_product_id, :company, :email, :phone, :status, :contacted_at

  index do
    selectable_column
    id_column
    column :company
    column :email
    column :phone
    column :status do |lead|
      lead.status.humanize
    end
    column :contacted_at
    column :user
    column :saas_product
    column :created_at
    actions
  end

  filter :company
  filter :email
  filter :status, as: :select, collection: SaasLead.statuses.keys.map { |k| [k.humanize, k] }
  filter :contacted_at
  filter :user
  filter :saas_product
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :saas_product
      f.input :company
      f.input :email
      f.input :phone
      f.input :status, as: :select, collection: SaasLead.statuses.keys.map { |k| [k.humanize, k] }
      f.input :contacted_at, as: :datepicker
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :saas_product
      row :company
      row :email
      row :phone
      row :status do |lead|
        lead.status.humanize
      end
      row :contacted_at
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item :mark_as_contacted, only: :show do
    link_to 'Mark as Contacted', mark_as_contacted_admin_saas_lead_path(saas_lead), method: :put unless saas_lead.contacted?
  end

  member_action :mark_as_contacted, method: :put do
    saas_lead = SaasLead.find(params[:id])
    saas_lead.contacted!
    redirect_to admin_saas_lead_path(saas_lead), notice: "Saas Lead marked as contacted!"
  end

end