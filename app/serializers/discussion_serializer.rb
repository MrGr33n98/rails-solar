class DiscussionSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :product_id,
             :category_id,
             :subject,
             :body,
             :status,
             :created_at,
             :updated_at

  belongs_to :user
  belongs_to :product
  belongs_to :category
end