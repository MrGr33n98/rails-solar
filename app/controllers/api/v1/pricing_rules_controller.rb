module Api
  module V1
    class PricingRulesController < ApplicationController
      def index
        pricing_rules = PricingRule.all
        render json: pricing_rules, each_serializer: PricingRuleSerializer
      end

      def show
        pricing_rule = PricingRule.find(params[:id])
        render json: pricing_rule, serializer: PricingRuleSerializer
      end
    end
  end
end