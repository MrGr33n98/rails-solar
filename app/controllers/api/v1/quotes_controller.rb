module Api
  module V1
    class QuotesController < ApplicationController
      def index
        quotes = Quote.all
        render json: quotes, each_serializer: QuoteSerializer
      end

      def show
        quote = Quote.find(params[:id])
        render json: quote, serializer: QuoteSerializer
      end
    end
  end
end