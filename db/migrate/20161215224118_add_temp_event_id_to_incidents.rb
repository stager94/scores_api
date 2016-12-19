class AddTempEventIdToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :temp_event_id, :integer
    add_index :incidents, :temp_event_id
  end
end
