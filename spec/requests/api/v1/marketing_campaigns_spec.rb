require 'rails_helper'

RSpec.describe "Api::V1::MarketingCampaigns", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/marketing_campaigns/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/marketing_campaigns/create"
      expect(response).to have_http_status(:success)
    end
  end

end
