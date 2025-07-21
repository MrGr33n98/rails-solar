class CreateAssessCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :assess_campaigns do |t|
      t.references :product, null: false, foreign_key: true
      t.string :title
      t.string :code
      t.references :owner, null: false, foreign_key: true
      t.integer :goal
      t.integer :achieved
      t.integer :shares
      t.string :prize
      t.date :starts_at
      t.date :ends_at
      t.integer :debutantes

      t.timestamps
    end
  end
end
