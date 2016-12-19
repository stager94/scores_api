class AddHomeTeamAndAwayTeamToEvents < ActiveRecord::Migration
  def change
    add_column :events, :home_team_id, :integer, index: true
    add_column :events, :away_team_id, :integer, index: true
    add_index :events, :home_team_id
    add_index :events, :away_team_id
  end
end
