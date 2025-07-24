require 'rails_helper'

RSpec.describe "Api::V1::Quotes", type: :request do
  describe "POST /create" do
    it "returns http success" do
      quote = create(:quote)
      post "/api/v1/quotes", params: { quote: quote.attributes }
      expect(response).to have_http_status(:success)
    end
  end

end
