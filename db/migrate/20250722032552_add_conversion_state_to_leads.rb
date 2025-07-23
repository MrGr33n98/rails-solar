class AddConversionStateToLeads < ActiveRecord::Migration[7.0]
  def change
    add_column :leads, :conversion_state, :integer, default: 0
  end
end
