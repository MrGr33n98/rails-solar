class AddLocationToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :location, :string
  end
end
