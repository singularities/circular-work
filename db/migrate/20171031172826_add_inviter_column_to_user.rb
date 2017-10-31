class AddInviterColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :inviter, foreign_key: true
  end
end
