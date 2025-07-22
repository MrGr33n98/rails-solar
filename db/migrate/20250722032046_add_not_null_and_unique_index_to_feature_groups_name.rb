class AddNotNullAndUniqueIndexToFeatureGroupsName < ActiveRecord::Migration[7.0]
  def change
    change_column_null :feature_groups, :name, false
    add_index :feature_groups, :name, unique: true
  end
end
