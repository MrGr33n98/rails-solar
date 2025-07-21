module Api
  module V1
    class AssessCampaignsController < ApplicationController
      def index
        assess_campaigns = AssessCampaign.all
        render json: assess_campaigns, each_serializer: AssessCampaignSerializer
      end

      def show
        assess_campaign = AssessCampaign.find(params[:id])
        render json: assess_campaign, serializer: AssessCampaignSerializer
      end
    end
  end
end