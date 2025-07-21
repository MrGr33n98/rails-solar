class CategorySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :slug,
             :description,
             :parent_id,
             :active,
             :depth,
             :created_at,
             :updated_at

  belongs_to :parent, if: -> { object.parent.present? }
  has_many :children
end