class UserStatusAggregatorService
  def initialize(external_user_id, client: DummyJsonClient.new)
    @external_user_id = external_user_id
    @client = client
    validate_external_id!
  end

  def call
    user_data = fetch_user_data
    todos_data = fetch_todos_data

    attributes = build_attributes(user_data, todos_data)
    user_status = find_user_status
    user_status.update!(attributes)
    user_status

  rescue StandardError => e
    Rails.logger.error "[UserStatusAggregatorService] Error: #{e.message}"
    raise
  end

  private

  def full_name(user_data)
    "#{user_data.fetch('firstName', '')} #{user_data.fetch('lastName', '')}".strip
  end

  def experience(user_data)
    user_data.fetch('age', 0) > 50 ? 'Veteran' : 'Rookie'
  end

  def pending_task_count(todos_data)
    todos_data['todos']&.count { |t| !t['completed'] }
  end

  def next_urgent_task(todos_data)
    todos_data['todos']&.find { |t| !t['completed'] }&.dig('todo') || ''
  end

  def fetch_user_data
    @client.user_data @external_user_id
  end

  def fetch_todos_data
    @client.todos_user_data @external_user_id
  end

  def find_user_status
    UserStatus.by_external_user_id(@external_user_id).first_or_initialize
  end

  def build_attributes(user_data, todos_data)
    {
      full_name: full_name(user_data),
      experience: experience(user_data),
      pending_task_count: pending_task_count(todos_data),
      next_urgent_task: next_urgent_task(todos_data)
    }
  end

  def validate_external_id!
    raise ArgumentError, "please provide a valid identificator" if @external_user_id.blank?
  end
end