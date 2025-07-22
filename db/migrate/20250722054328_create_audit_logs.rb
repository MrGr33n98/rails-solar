class CreateAuditLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :audit_logs do |t|
      t.string :auditable_type
      t.integer :auditable_id
      t.integer :user_id
      t.string :action
      t.text :changes # Stores JSON representation of changes

      t.timestamps
    end
  end
end
