class AddUtmFieldsToLeads < ActiveRecord::Migration[7.0]
  def change
    add_column :leads, :utm_campaign, :string
    add_column :leads, :utm_source, :string
    add_column :leads, :utm_medium, :string
  end
end
