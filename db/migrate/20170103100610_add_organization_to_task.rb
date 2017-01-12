class AddOrganizationToTask < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :organization, foreign_key: true
  end
end
