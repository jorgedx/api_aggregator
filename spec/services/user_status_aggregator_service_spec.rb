require 'rails_helper'

RSpec.describe UserStatusAggregatorService, type: :service do
  let(:user_id) { 1 }
  let(:client) { instance_double("DummyJsonClient") }

  subject(:service) { described_class.new(user_id, client: client) }

  before do
    allow(client).to receive(:user_data).with(user_id).and_return({
      'firstName' => 'Criss', 'lastName' => 'Cross', 'age' => 23
    })
    
    allow(client).to receive(:todos_user_data).with(user_id).and_return({
      'todos' => [
        { 'todo' => 'Send an email to the team', 'completed' => false },
        { 'todo' => 'Go to concert', 'completed' => false }
      ],
      'total': 2, 'skip': 0, 'limit': 2
    })
  end

  it 'persists user status' do
    expect { service.call }.to change(UserStatus, :count).by(1)
    
    status = UserStatus.last
    expect(status.full_name).to eq('Criss Cross')
    expect(status.experience).to eq('Rookie')
    expect(status.pending_task_count).to eq(2)
    expect(status.next_urgent_task).to eq('Send an email to the team')
  end
end