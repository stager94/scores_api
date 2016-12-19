class AddTeamIdToIncidents < ActiveRecord::Migration
  def change
    add_reference :incidents, :event, index: true, foreign_key: true
  end
end
