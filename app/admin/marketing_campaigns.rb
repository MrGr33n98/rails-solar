ActiveAdmin.register MarketingCampaign do

  permit_params :name, :channel, :template, :scheduled_at

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

  # Example of a custom action for dispatching a campaign
  # action_item :dispatch, only: :show do
  #   link_to 'Dispatch Campaign', dispatch_admin_marketing_campaign_path(marketing_campaign), method: :put
  # end

  # member_action :dispatch, method: :put do
  #   marketing_campaign = MarketingCampaign.find(params[:id])
  #   # Add logic to dispatch the campaign here
  #   redirect_to admin_marketing_campaign_path(marketing_campaign), notice: "Campaign dispatched!"
  # end

end
