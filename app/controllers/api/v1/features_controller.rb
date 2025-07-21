module Api
  module V1
    class FeaturesController < ApplicationController
      def index
        features = Feature.all
        render json: features, each_serializer: FeatureSerializer
      end

      def show
        feature = Feature.find(params[:id])
        render json: feature, serializer: FeatureSerializer
      end
    end
  end
end