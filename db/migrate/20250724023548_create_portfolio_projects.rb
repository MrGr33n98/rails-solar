class CreatePortfolioProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_projects do |t|
      t.string :title
      t.text :description
      t.references :company, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
