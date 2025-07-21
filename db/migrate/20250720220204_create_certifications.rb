class CreateCertifications < ActiveRecord::Migration[7.0]
  def change
    create_table :certifications do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.string :issued_by
      t.date :issued_at
      t.date :expires_at

      t.timestamps
    end
  end
end
