class AddIsHomeToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :is_home, :boolean
  end
end
