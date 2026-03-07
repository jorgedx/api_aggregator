require 'rails_helper'

RSpec.describe "UserStatuses", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/user_statuses/show"
      expect(response).to have_http_status(:success)
    end
  end

end
