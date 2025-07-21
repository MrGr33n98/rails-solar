class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :message
      t.references :company, null: false, foreign_key: true
      t.integer :status
      t.decimal :estimated_kwh

      t.timestamps
    end
  end
end
