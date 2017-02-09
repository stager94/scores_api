class ChangeProtocolDefaultInEvents < ActiveRecord::Migration
  def change
    remove_column :events, :protocol
    add_column :events, :protocol, :hstore, default: ''
  end
end
