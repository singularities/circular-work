class AddAuthorToTasks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :author, foreign_key: true
  end
end
