class AddNotNullToMarketingCampaignsFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :marketing_campaigns, :name, false
    change_column_null :marketing_campaigns, :channel, false
    change_column_null :marketing_campaigns, :template, false
    change_column_null :marketing_campaigns, :scheduled_at, false
  end
end
