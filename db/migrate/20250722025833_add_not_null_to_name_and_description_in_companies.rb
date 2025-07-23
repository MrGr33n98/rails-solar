class AddNotNullToNameAndDescriptionInCompanies < ActiveRecord::Migration[7.0]
  def change
    change_column_null :companies, :name, false
    change_column_null :companies, :description, false
  end
end
