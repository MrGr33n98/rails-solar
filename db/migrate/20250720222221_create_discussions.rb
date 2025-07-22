class CreateDiscussions < ActiveRecord::Migration[7.0]
  def change
    create_table :discussions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :subject, null: false
      t.text :body, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
