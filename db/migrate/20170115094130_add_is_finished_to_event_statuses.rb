class AddIsFinishedToEventStatuses < ActiveRecord::Migration
  def change
    add_column :event_statuses, :is_finished, :boolean, default: false
  end
end
