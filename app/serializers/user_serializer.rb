class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :role, :phone, :banned_until, :is_super_admin, :created_at, :updated_at
end