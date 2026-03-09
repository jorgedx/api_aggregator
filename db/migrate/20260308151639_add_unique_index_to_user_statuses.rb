class AddUniqueIndexToUserStatuses < ActiveRecord::Migration[7.2]
  def change
    remove_index :user_statuses, :external_user_id
    
    add_index :user_statuses, :external_user_id, unique: true
    change_column_null :user_statuses, :external_user_id, false
  end
end
