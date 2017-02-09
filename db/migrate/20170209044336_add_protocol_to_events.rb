class AddProtocolToEvents < ActiveRecord::Migration
  def change
    add_column :events, :protocol, :hstore
  end
end
