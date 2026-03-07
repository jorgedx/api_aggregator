class UserStatusPresenter
  def initialize(user_status)
    @user_status = user_status
  end

  def as_json(_options = {})
    {
      id: @user_status.id,
      full_name: @user_status.full_name,
      experience: @user_status.experience,
      pending_task_count: @user_status.pending_task_count,
      next_urgent_task: @user_status.next_urgent_task
    }
  end
end