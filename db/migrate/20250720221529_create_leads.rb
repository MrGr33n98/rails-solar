class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :role
      t.string :company_size
      t.string :desired_category
      t.string :funnel_stage
      t.integer :score
      t.date :sent_at

      t.timestamps
    end
  end
end
