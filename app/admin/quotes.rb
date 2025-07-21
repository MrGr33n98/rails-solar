ActiveAdmin.register Quote do

  permit_params :name, :email, :phone, :message, :company_id, :status, :estimated_kwh, :user_id

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :status do |quote|
      quote.status.humanize
    end
    column :estimated_kwh
    column :company
    column :user
    column :created_at
    actions
  end

  filter :email
  filter :status, as: :select, collection: Quote.statuses.keys.map { |k| [k.humanize, k] }
  filter :estimated_kwh
  filter :company
  filter :user
  filter :created_at

  form do |f|
    f.inputs do
      f.input :company
      f.input :user
      f.input :name
      f.input :email
      f.input :phone
      f.input :message
      f.input :status, as: :select, collection: Quote.statuses.keys.map { |k| [k.humanize, k] }
      f.input :estimated_kwh
    end
    f.actions
  end

  show do
    attributes_table do
      row :company
      row :user
      row :name
      row :email
      row :phone
      row :message
      row :status do |quote|
        quote.status.humanize
      end
      row :estimated_kwh
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item :mark_as_responded, only: :show do
    link_to 'Mark as Responded', mark_as_responded_admin_quote_path(quote), method: :put unless quote.responded?
  end

  member_action :mark_as_responded, method: :put do
    quote = Quote.find(params[:id])
    quote.responded!
    redirect_to admin_quote_path(quote), notice: "Quote marked as responded!"
  end

end
