class AddEventsLastLoadDateToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :events_last_load_timestamp, :integer
  end
end
