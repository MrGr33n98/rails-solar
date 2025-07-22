class RemoveOldCategoryForeignKeyFromDiscussions < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :discussions, column: :category_id, to_table: :categories_old
  end
end
