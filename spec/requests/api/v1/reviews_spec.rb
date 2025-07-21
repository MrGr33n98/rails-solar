require 'rails_helper'

RSpec.describe "Api::V1::Reviews", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/reviews/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/reviews/create"
      expect(response).to have_http_status(:success)
    end
  end

end
