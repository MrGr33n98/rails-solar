class RenameChangesToAuditedChangesInAuditLogs < ActiveRecord::Migration[7.0]
  def change
    rename_column :audit_logs, :changes, :audited_changes
  end
end
