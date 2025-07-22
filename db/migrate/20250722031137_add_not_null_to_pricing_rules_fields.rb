class AddNotNullToPricingRulesFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :pricing_rules, :name, false
    change_column_null :pricing_rules, :condition, false
    change_column_null :pricing_rules, :discount_pct, false
  end
end
