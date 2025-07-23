class AddNotNullAndUniqueIndexToProductsFields < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :name, false
    change_column_null :products, :status, false
    change_column_null :products, :kind, false
    change_column_null :products, :seo_title, false
  end
end
