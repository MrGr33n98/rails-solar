class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :views, :role
end