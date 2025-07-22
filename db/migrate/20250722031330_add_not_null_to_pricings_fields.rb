class AddNotNullToPricingsFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :pricings, :title, false
    change_column_null :pricings, :currency, false
    change_column_null :pricings, :value, false
    change_column_null :pricings, :charge_type, false
    change_column_null :pricings, :frequency, false
  end
end
