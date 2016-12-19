class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :country
      t.string :city
      t.string :stadium_name
      t.integer :stadium_capacity
      t.integer :external_id

      t.timestamps null: false
    end
    add_index :venues, :external_id
  end
end
