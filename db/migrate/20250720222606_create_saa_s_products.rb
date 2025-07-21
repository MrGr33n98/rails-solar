class CreateSaaSProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :saa_s_products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :billing_cycle
      t.text :features
      t.boolean :active

      t.timestamps
    end
  end
end
