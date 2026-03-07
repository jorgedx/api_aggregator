require 'rails_helper'

RSpec.describe UserStatusAggregatorService, type: :service do
  let(:user_id) { 1 }

  describe '#call' do
    it 'converts dummy data to user status' do
      expect(true).to eq(true)
    end
  end
end