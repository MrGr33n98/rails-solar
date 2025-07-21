class FeatureSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :feature_group_id,
             :created_at,
             :updated_at

  belongs_to :feature_group
end
