class AddTokenToOrganization < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :token, :string

    reversible do |dir|
      dir.up do
        Organization.reset_column_information

        Organization.all.each(&:refresh_token)
      end
    end
  end
end
