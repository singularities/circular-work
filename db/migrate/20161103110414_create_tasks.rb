class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :recurrence, default: 0
      t.string :recurrence_match, default: ''
      t.string :email
      t.string :notification_subject
      t.text :notification_body

      t.timestamps
    end
  end
end
