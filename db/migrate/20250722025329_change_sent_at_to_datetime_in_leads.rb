class ChangeSentAtToDatetimeInLeads < ActiveRecord::Migration[7.0]
  def change
    change_column :leads, :sent_at, :datetime
  end
end
