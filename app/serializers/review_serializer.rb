class ReviewSerializer < ActiveModel::Serializer
  attributes :id,
             :rating,
             :title,
             :content,
             :status,
             :created_at,
             :updated_at

  belongs_to :company
  belongs_to :user
end
