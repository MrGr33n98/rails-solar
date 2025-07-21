class ProductSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :seo_url,
             :seo_title,
             :status,
             :kind,
             :premium_until,
             :source,
             :country,
             :created_at,
             :updated_at

  has_many :categories
  has_many :feature_groups
end
