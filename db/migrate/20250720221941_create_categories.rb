class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.references :parent, null: false, foreign_key: true
      t.boolean :active
      t.integer :depth
      t.string :ancestry

      t.timestamps
    end
  end
end
