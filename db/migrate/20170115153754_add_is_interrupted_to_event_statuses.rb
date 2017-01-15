class AddIsInterruptedToEventStatuses < ActiveRecord::Migration
  def change
    add_column :event_statuses, :is_interrupted, :boolean, default: false
  end
end
