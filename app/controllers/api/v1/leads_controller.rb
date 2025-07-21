module Api
  module V1
    class LeadsController < ApplicationController
      def index
        leads = Lead.all
        render json: leads, each_serializer: LeadSerializer
      end

      def show
        lead = Lead.find(params[:id])
        render json: lead, serializer: LeadSerializer
      end
    end
  end
end