module Api
  module V1
    class MarketingCampaignsController < ApplicationController
      # Only admins can manage campaigns
      before_action :authenticate_user!
      before_action :authorize_admin!

      # GET /api/v1/marketing_campaigns
      def index
        campaigns = MarketingCampaign.all
        render json: campaigns, each_serializer: MarketingCampaignSerializer
      end

      # POST /api/v1/marketing_campaigns
      def create
        campaign = MarketingCampaign.new(campaign_params)
        if campaign.save
          render json: campaign, serializer: MarketingCampaignSerializer, status: :created
        else
          render json: { errors: campaign.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def campaign_params
        params.require(:marketing_campaign).permit(
          :name,
          :channel,
          :template,
          :scheduled_at
        )
      end

      def authorize_admin!
        unless current_user.super_admin? || current_user.company_admin?
          render json: { error: 'Access denied' }, status: :forbidden
        end
      end
    end
  end
end
