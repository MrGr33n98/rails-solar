class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :title, null: false
      t.string :short_description, null: false
      t.string :tags
      t.string :lp_url
      t.string :format, null: false
      t.string :level, null: false
      t.boolean :active

      t.timestamps
    end
  end
end
