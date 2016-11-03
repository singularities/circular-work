class CreateResponsibilities < ActiveRecord::Migration[5.0]
  def change
    create_table :responsibilities do |t|
      t.references :turn, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
