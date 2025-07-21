module Api
  module V1
    class CategoriesController < ApplicationController
      # GET /api/v1/categories
      def index
        # Returns only root categories with their children loaded
        categories = Category.includes(:children).where(parent_id: nil)
        render json: categories, each_serializer: CategorySerializer
      end

      # GET /api/v1/categories/:id
      def show
        category = Category.find(params[:id])
        # Includes subcategories in the response
        render json: category, serializer: CategorySerializer
      end
    end
  end
end
