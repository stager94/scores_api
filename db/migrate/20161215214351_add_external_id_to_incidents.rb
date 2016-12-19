class AddExternalIdToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :external_id, :integer
    add_index :incidents, :external_id
  end
end
