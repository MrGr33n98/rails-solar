class AssessCampaignSerializer < ActiveModel::Serializer
  attributes :id,
             :product_id,
             :title,
             :code,
             :owner_id,
             :goal,
             :achieved,
             :shares,
             :prize,
             :debutantes,
             :starts_at,
             :ends_at,
             :created_at,
             :updated_at

  belongs_to :product
  belongs_to :owner, serializer: UserSerializer
end