module Api
  module V1
    class PricingsController < ApplicationController
      def index
        pricings = Pricing.all
        render json: pricings, each_serializer: PricingSerializer
      end

      def show
        pricing = Pricing.find(params[:id])
        render json: pricing, serializer: PricingSerializer
      end
    end
  end
end