class RenameNotificationEmailInTasks < ActiveRecord::Migration[5.0]
  def change
    rename_column :tasks, :email, :notification_email
  end
end
