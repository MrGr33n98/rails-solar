module Api
  module V1
    class CompaniesController < ApplicationController
      # GET /api/v1/companies
      def index
        companies = Company.all
        render json: companies, each_serializer: CompanySerializer
      end

      # GET /api/v1/companies/:id
      def show
        company = Company.find(params[:id])
        render json: company, serializer: CompanySerializer
      end
    end
  end
end