require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "GET /dashboard" do
    it "returns http success" do
      get "/admins/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

end
