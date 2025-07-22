class AddStatusToSaaSProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :saa_s_products, :status, :string
  end
end
