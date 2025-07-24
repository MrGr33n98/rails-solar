class AddConversionStateToLeads < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:leads, :conversion_state)
      add_column :leads, :conversion_state, :integer, default: 0
    end
  end
end
