class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.0]
  def change
    change_table(:users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## User Info
      t.string :name

      ## Tokens
      t.text :tokens
    end

    reversible do |dir|
      dir.up do
        remove_column :users, :authentication_token

        User.reset_column_information

        User.all.each do |user|
          user.uid = user.email
          user.tokens = nil
          user.save!
        end
      end

      dir.down do
        add_column :users, :authentication_token, :string
      end
    end

    add_index :users, [:uid, :provider],     unique: true
  end
end
