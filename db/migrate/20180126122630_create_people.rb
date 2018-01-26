class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.references :role, foreign_key: true
      t.references :location, foreign_key: true
      t.integer :manager_id
      t.integer :salary

      t.timestamps
    end
  end
end
