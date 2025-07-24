class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :views, :user_id, :published_at
end