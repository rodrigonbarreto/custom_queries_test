class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.references :region, foreign_key: true

      t.timestamps
    end
  end
end
