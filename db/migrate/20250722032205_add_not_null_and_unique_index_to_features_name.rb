class AddNotNullAndUniqueIndexToFeaturesName < ActiveRecord::Migration[7.0]
  def change
    change_column_null :features, :name, false
    add_index :features, [:name, :feature_group_id], unique: true
  end
end
