class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :role, null: false
      t.string :company_size
      t.string :desired_category
      t.string :funnel_stage
      t.integer :score
      t.date :sent_at
      t.integer :conversion_state, null: false, default: 0

      t.timestamps
    end
  end
end
