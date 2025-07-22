class CreateJoinTableCategoriesProducts < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :products do |t|
      # Índices para buscas e unicidade
      t.index [:category_id, :product_id], unique: true, name: 'index_categories_products_on_category_and_product'
      t.index [:product_id, :category_id], name: 'index_categories_products_on_product_and_category'

      # (Opcional) Se quiser timestamps na associação:
      # t.timestamps
    end
  end
end
