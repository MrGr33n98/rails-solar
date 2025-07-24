require 'rails_helper'

RSpec.describe "Api::V1::Reviews", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/reviews"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      review = create(:review)
      post "/api/v1/reviews", params: { review: review.attributes }
      expect(response).to have_http_status(:success)
    end
  end

end
