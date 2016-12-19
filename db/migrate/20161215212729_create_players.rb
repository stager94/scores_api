class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :slug, unique: true
      t.string :short_name
      t.integer :external_id, unique: true

      t.timestamps null: false
    end
    add_index :players, :external_id
  end
end
