module Api
  module V1
    class ContentsController < ApplicationController
      def index
        contents = Content.all
        render json: contents, each_serializer: ContentSerializer
      end

      def show
        content = Content.find(params[:id])
        render json: content, serializer: ContentSerializer
      end
    end
  end
end