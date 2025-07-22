class AddConstraintsAndIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, :slug, unique: true
    add_index :products, :seo_url, unique: true
    add_foreign_key :assess_campaigns, :products
    add_foreign_key :assess_campaigns, :users, column: :owner_id
    change_column_null :companies, :name, false
    change_column_null :companies, :user_id, false
    # Adicione outras restrições conforme necessário
  end
end
