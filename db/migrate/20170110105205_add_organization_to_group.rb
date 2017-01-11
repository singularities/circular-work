class AddOrganizationToGroup < ActiveRecord::Migration[5.0]
  def up
    add_reference :groups, :organization, foreign_key: true

    Group.all.each do |group|
      if group.tasks.any? && group.tasks.first.organization
        group.organization = group.tasks.first.organization
        group.save!
      else
        group.destroy!
      end
    end
  end

  def down
    remove_reference :groups, :organization, foreign_key: true
  end
end
