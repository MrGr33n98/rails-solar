module Api
  module V1
    class DiscussionsController < ApplicationController
      def index
        discussions = Discussion.all
        render json: discussions, each_serializer: DiscussionSerializer
      end

      def show
        discussion = Discussion.find(params[:id])
        render json: discussion, serializer: DiscussionSerializer
      end
    end
  end
end