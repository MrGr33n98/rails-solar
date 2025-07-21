class QuoteSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :phone,
             :message,
             :status,
             :estimated_kwh,
             :created_at,
             :updated_at

  belongs_to :company
  belongs_to :user, if: -> { object.user.present? }
end
