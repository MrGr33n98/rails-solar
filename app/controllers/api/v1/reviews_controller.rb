module Api
  module V1
    class ReviewsController < ApplicationController
      # Ensures only authenticated users can create or list
      before_action :authenticate_user!

      # GET /api/v1/reviews
      # If admin, returns all reviews; otherwise, only the user's own reviews
      def index
        reviews = if current_user.super_admin? || current_user.company_admin?
                    Review.all
                  else
                    current_user.reviews
                  end

        render json: reviews, each_serializer: ReviewSerializer
      end

      # POST /api/v1/reviews
      def create
        review = current_user.reviews.build(review_params)
        if review.save
          render json: review, serializer: ReviewSerializer, status: :created
        else
          render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def review_params
        params.require(:review).permit(
          :company_id,
          :rating,
          :title,
          :content,
          :status
        )
      end
    end
  end
end
