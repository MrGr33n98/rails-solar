class AddNotNullToAssessCampaignsFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :assess_campaigns, :title, false
    change_column_null :assess_campaigns, :code, false
    change_column_null :assess_campaigns, :goal, false
    change_column_null :assess_campaigns, :starts_at, false
    change_column_null :assess_campaigns, :ends_at, false
  end
end
