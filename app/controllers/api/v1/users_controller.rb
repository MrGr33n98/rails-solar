module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        render json: users, each_serializer: UserSerializer
      end

      def show
        user = User.find(params[:id])
        render json: user, serializer: UserSerializer
      end
    end
  end
end