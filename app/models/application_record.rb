class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include Auditable # Example of including a concern

  # Common utility method example
  def self.human_attribute_name(attribute, options = {})
    super
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email created_at updated_at]
  end
end
