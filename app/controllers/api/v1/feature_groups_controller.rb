module Api
  module V1
    class FeatureGroupsController < ApplicationController
      def index
        feature_groups = FeatureGroup.all
        render json: feature_groups, each_serializer: FeatureGroupSerializer
      end

      def show
        feature_group = FeatureGroup.find(params[:id])
        render json: feature_group, serializer: FeatureGroupSerializer
      end
    end
  end
end