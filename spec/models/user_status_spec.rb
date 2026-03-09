require 'rails_helper'

RSpec.describe UserStatus, type: :model do
  subject(:user_status) do
    described_class.new(
      external_user_id: 1,
      full_name: "Criss Cross",
      experience: "Rookie",
      pending_task_count: 2
    )
  end

  describe "Validations" do
    it "valid with correct attributes" do
      expect(user_status).to be_valid
    end

    it "not have a valid external_user_id" do
      user_status.external_user_id = nil
      expect(user_status).not_to be_valid
    end

    it "not valid if external_user_id is duplicated" do
      user_status.save!
      duplicated = user_status.dup
      expect(duplicated).not_to be_valid
    end

    it "not valid if pending_task_count is negative" do
      user_status.pending_task_count = -1
      expect(user_status).not_to be_valid
    end
  end
end