module Auditable
  extend ActiveSupport::Concern

  included do
    # after_save :log_changes
  end

  def log_changes
    if self.changed?
      AuditLog.create!(
        auditable_type: self.class.name,
        auditable_id: self.id,
        action: self.new_record? ? 'create' : 'update',
        audited_changes: self.changes.transform_values { |v| [v[0].to_s, v[1].to_s] }.to_json
      ).tap do |log|
        log.user_id = Current.user.id if defined?(Current) && Current.user
      end
    end
  end
end
