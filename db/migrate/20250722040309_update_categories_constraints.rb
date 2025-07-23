class UpdateCategoriesConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :categories, :parent_id, true
    change_column_null :categories, :name, false
    change_column_null :categories, :slug, false
    add_index :categories, [:slug, :parent_id], unique: true
  end
end
