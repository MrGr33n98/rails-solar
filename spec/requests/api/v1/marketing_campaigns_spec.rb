require 'rails_helper'

RSpec.describe "Api::V1::MarketingCampaigns", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/marketing_campaigns"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      marketing_campaign = create(:marketing_campaign)
      post "/api/v1/marketing_campaigns", params: { marketing_campaign: marketing_campaign.attributes }
      expect(response).to have_http_status(:success)
    end
  end

end
