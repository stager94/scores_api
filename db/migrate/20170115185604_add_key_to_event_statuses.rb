class AddKeyToEventStatuses < ActiveRecord::Migration
  def change
    add_column :event_statuses, :key, :string, default: "unknown"
    add_index :event_statuses, :key
  end
end
