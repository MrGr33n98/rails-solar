class MarketingCampaignSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :channel,
             :template,
             :scheduled_at,
             :created_at,
             :updated_at
end