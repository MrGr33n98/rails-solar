class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.boolean :verified
      t.integer :target_segment
      t.decimal :annual_energy_output
      t.integer :installation_count

      t.timestamps
    end
  end
end
