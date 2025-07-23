class AddNotNullToSaasProductsFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :saa_s_products, :name, false
    change_column_null :saa_s_products, :description, false
    change_column_null :saa_s_products, :price, false
    change_column_null :saa_s_products, :billing_cycle, false
    change_column_null :saa_s_products, :status, false
  end
end
