class ContentSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :short_description,
             :tags,
             :lp_url,
             :format,
             :level,
             :active,
             :created_at,
             :updated_at
end