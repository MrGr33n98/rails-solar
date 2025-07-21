class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :seo_url
      t.string :seo_title
      t.string :status
      t.string :kind
      t.date :premium_until
      t.string :source
      t.string :country

      t.timestamps
    end
  end
end
