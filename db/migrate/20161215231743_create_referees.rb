class CreateReferees < ActiveRecord::Migration
  def change
    create_table :referees do |t|
      t.string :name
      t.integer :external_id
      t.string :country

      t.timestamps null: false
    end
    add_index :referees, :external_id
  end
end
