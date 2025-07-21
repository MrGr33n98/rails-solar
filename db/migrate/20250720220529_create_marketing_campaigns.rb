class CreateMarketingCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :marketing_campaigns do |t|
      t.string :name
      t.integer :channel
      t.text :template
      t.datetime :scheduled_at

      t.timestamps
    end
  end
end
