module Api
  module V1
    class SaasPlansController < ApplicationController
      def index
        saas_plans = SaasPlan.all
        render json: saas_plans, each_serializer: SaasPlanSerializer
      end

      def show
        saas_plan = SaasPlan.find(params[:id])
        render json: saas_plan, serializer: SaasPlanSerializer
      end
    end
  end
end