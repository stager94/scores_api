class AddInProcessToEventStatuses < ActiveRecord::Migration
  def change
    add_column :event_statuses, :in_process, :boolean, default: false
  end
end
