class UserStatus < ApplicationRecord
  validates :external_user_id, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :experience, presence: true
  validates :pending_task_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :by_external_user_id, ->(id) { where(external_user_id: id) }

end
