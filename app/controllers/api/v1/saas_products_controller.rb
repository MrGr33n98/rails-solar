module Api
  module V1
    class SaasProductsController < ApplicationController
      def index
        saas_products = SaasProduct.all
        render json: saas_products, each_serializer: SaasProductSerializer
      end

      def show
        saas_product = SaasProduct.find(params[:id])
        render json: saas_product, serializer: SaasProductSerializer
      end
    end
  end
end