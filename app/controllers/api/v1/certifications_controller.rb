module Api
  module V1
    class CertificationsController < ApplicationController
      def index
        certifications = Certification.all
        render json: certifications, each_serializer: CertificationSerializer
      end

      def show
        certification = Certification.find(params[:id])
        render json: certification, serializer: CertificationSerializer
      end
    end
  end
end