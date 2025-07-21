require 'rails_helper'

RSpec.describe "Api::V1::Quotes", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/quotes/create"
      expect(response).to have_http_status(:success)
    end
  end

end
