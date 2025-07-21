module Api
  module V1
    class SaasLeadsController < ApplicationController
      def index
        saas_leads = SaasLead.all
        render json: saas_leads, each_serializer: SaasLeadSerializer
      end

      def show
        saas_lead = SaasLead.find(params[:id])
        render json: saas_lead, serializer: SaasLeadSerializer
      end
    end
  end
end