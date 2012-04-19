class RemoveUsernameToUserSessions < ActiveRecord::Migration
  def up
    remove_column :user_sessions, :username
  end

  def down
    add_column :user_sessions, :username, :string
  end
end
