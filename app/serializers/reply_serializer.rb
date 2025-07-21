class ReplySerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :discussion_id,
             :body,
             :status,
             :created_at,
             :updated_at

  belongs_to :user
  belongs_to :discussion
end