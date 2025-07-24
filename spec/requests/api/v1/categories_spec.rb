require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  before(:each) do
    login_user_helper
  end

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/categories"
      expect(response).to have_http_status(:success)
    end
  end

end
