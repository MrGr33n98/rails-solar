class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :short_description
      t.string :tags
      t.string :lp_url
      t.string :format
      t.string :level
      t.boolean :active

      t.timestamps
    end
  end
end
