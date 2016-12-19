class CreateEventStatuses < ActiveRecord::Migration
  def change
    create_table :event_statuses do |t|
      t.integer :code
      t.string :description
      t.string :type

      t.timestamps null: false
    end
  end
end
