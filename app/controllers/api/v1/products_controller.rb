module Api
  module V1
    class ProductsController < ApplicationController
      # GET /api/v1/products
      def index
        products = Product.includes(:categories, :feature_groups).all
        render json: products, each_serializer: ProductSerializer
      end

      # GET /api/v1/products/:id
      def show
        product = Product.find(params[:id])
        render json: product, serializer: ProductSerializer
      end
    end
  end
end
