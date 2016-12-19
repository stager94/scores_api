class AddMissedInfoToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :venue, index: true, foreign_key: true
    add_reference :events, :referee, index: true, foreign_key: true
    add_reference :events, :season, index: true, foreign_key: true
    add_reference :events, :competition, index: true, foreign_key: true
  end
end
