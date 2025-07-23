class ChangeDatesToDatetimeInAssessCampaigns < ActiveRecord::Migration[7.0]
  def change
    change_column :assess_campaigns, :starts_at, :datetime
    change_column :assess_campaigns, :ends_at, :datetime
  end
end
