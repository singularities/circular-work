class AddAuthorToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_reference :organizations, :author, foreign_key: { to_table: :users }
  end
end
