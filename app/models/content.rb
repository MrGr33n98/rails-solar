class Content < ApplicationRecord
  # include Versionable # Placeholder for a versioning concern

  validates :title, :short_description, :format, :level, presence: true
  validates :format, inclusion: { in: %w[article video infographic podcast], message: "%<value>s is not a valid format" }
  validates :level, inclusion: { in: %w[beginner intermediate advanced], message: "%<value>s is not a valid level" }

  scope :published, -> { where(active: true) }

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes = %w[id title short_description tags lp_url format level active created_at updated_at]
    super + authorizable_ransackable_attributes
  end
end
