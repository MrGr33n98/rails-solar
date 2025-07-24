class CreateProductInquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :product_inquiries do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
