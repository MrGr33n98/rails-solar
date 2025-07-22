ActiveAdmin.register MarketingCampaign do
  permit_params :name, :channel, :template, :scheduled_at

  # Scopes para as abas
  scope :all, default: true
  scope("ATIVOS")         { |c| c.where(channel: 'active') }
  scope("Planos Ouro")    { |c| c.where(channel: 'gold') }
  scope("Planos Prata")   { |c| c.where(channel: 'silver') }
  scope("Planos Bronze")  { |c| c.where(channel: 'bronze') }
  scope("Planos Amostra") { |c| c.where(channel: 'sample') }

  index do
    selectable_column
    id_column
    column :name
    column :channel do |campaign|
      campaign.channel.humanize
    end
    column :template
    column :scheduled_at
    column :created_at
    actions
  end

  filter :name
  filter :channel, as: :select, collection: MarketingCampaign.channels.keys.map { |k| [k.humanize, k] }
  filter :scheduled_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :channel, as: :select, collection: MarketingCampaign.channels.keys.map { |k| [k.humanize, k] }
      f.input :template
      f.input :scheduled_at, as: :datepicker
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :channel do |campaign|
        campaign.channel.humanize
      end
      row :template
      row :scheduled_at
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
