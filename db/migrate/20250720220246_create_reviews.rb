class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.integer :rating
      t.string :title
      t.text :content
      t.integer :status
      t.boolean :cliente

      t.timestamps
    end
  end
end
