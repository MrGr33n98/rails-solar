module Api
  module V1
    class RepliesController < ApplicationController
      def index
        replies = Reply.all
        render json: replies, each_serializer: ReplySerializer
      end

      def show
        reply = Reply.find(params[:id])
        render json: reply, serializer: ReplySerializer
      end
    end
  end
end