class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :external_id
      t.integer :home_score, default: 0
      t.integer :away_score, default: 0
      t.hstore :home_scores
      t.hstore :away_scores
      t.references :event_status, index: true, foreign_key: true
      t.string :name
      t.datetime :started_at

      t.timestamps null: false
    end
    add_index :events, :external_id
  end
end
