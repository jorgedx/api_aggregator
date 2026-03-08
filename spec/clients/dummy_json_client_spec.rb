require 'rails_helper'

RSpec.describe DummyJsonClient do
  let(:client) { described_class.new }
  let(:user_id) { 4 }

  let(:user_json) { { "id" => 4, "firstName" => "James", "lastName" => "Davis", "age" => 46 }.to_json }
  let(:todos_json) { { "todos" => [], "total" => 0 }.to_json }

  before do
    stub_request(:get, "https://dummyjson.com/users/#{user_id}")
      .to_return(status: 200, body: user_json, headers: { 'Content-Type' => 'application/json' })

    stub_request(:get, "https://dummyjson.com/todos/user/#{user_id}")
      .to_return(status: 200, body: todos_json, headers: { 'Content-Type' => 'application/json' })
  end

  describe '#user_data' do
    it 'returns the user dummy json data by id' do
      result = client.user_data(user_id)
      expect(result['firstName']).to eq('James')
      expect(result['age']).to eq(46)
    end
  end

  describe '#todos_user_data' do
    it 'returns the todos for the user' do
      result = client.todos_user_data(user_id)
      expect(result['todos']).to be_empty
    end
  end

  describe 'error handling record not found' do
    it 'raise if response is 404' do
      stub_request(:get, "https://dummyjson.com/users/999")
        .to_return(status: 404, body: "Not Found")

      expect { client.user_data(999) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'error handling 400' do
    it 'raise if response is bad request' do
      stub_request(:get, "https://dummyjson.com/users/9ii")
        .to_return(status: 400, body: "Bad Request")

      expect { client.user_data('9ii') }.to raise_error(ActionController::BadRequest)
    end
  end
end