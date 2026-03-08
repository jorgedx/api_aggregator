require 'rails_helper'

RSpec.describe "UserStatuses", type: :request do
  describe "GET /user_status/:id" do
    let(:user_id) { 1 }
    
    let(:user_status) do
      UserStatus.create!(
        external_user_id: user_id,
        full_name: "Criss Cross",
        experience: "Rookie",
        pending_task_count: 2,
        next_urgent_task: "Send an email to the team"
      )
    end

    before do
      allow_any_instance_of(UserStatusAggregatorService).to receive(:call).and_return(user_status)
    end

    it "returns success and the expected json" do
      get "/user_status/#{user_id}"
      
      expect(response).to have_http_status(:success)
      
      json_response = JSON.parse(response.body)
      expect(json_response["full_name"]).to eq("Criss Cross")
      expect(json_response["experience"]).to eq("Rookie")
      expect(json_response["pending_task_count"]).to eq(2)
    end
  end
end