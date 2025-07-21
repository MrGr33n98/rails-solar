class CreatePricingRules < ActiveRecord::Migration[7.0]
  def change
    create_table :pricing_rules do |t|
      t.string :name
      t.text :condition
      t.decimal :discount_pct

      t.timestamps
    end
  end
end
