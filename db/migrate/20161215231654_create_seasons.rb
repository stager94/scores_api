class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.references :competition, index: true, foreign_key: true
      t.string :name
      t.string :slug
      t.string :year
      t.integer :external_id
      t.boolean :is_active

      t.timestamps null: false
    end
    add_index :seasons, :external_id
  end
end
