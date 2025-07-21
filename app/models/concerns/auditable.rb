module Auditable
  extend ActiveSupport::Concern

  included do
    before_save :log_changes
  end

  def log_changes
    # Placeholder for auditing logic
    # Example: Log changes to a separate audit table or a log file
    # puts "Changes for #{self.class.name} (ID: #{id}): #{changes}"
  end
end
