class CreateSaaSPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :saa_s_plans do |t|
      t.string :name, null: false
      t.references :saas_product, null: false, foreign_key: true
      t.string :tier, null: false
      t.text :features
      t.decimal :price, null: false
      t.boolean :active

      t.timestamps
    end
  end
end
