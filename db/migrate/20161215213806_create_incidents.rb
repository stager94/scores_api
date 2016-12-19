class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.references :player, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true
      t.integer :time, default: 0
      t.integer :added_time, default: 0
      t.string :incident_type
      t.string :incident_class
      t.string :description
      t.hstore :params

      t.timestamps null: false
    end
  end
end
