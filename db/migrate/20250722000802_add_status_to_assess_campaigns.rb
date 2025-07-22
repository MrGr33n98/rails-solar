class AddStatusToAssessCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :assess_campaigns, :status, :string
  end
end
