class AddUtmFieldsToMarketingCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :marketing_campaigns, :utm_campaign, :string
    add_column :marketing_campaigns, :utm_source, :string
    add_column :marketing_campaigns, :utm_medium, :string
  end
end
