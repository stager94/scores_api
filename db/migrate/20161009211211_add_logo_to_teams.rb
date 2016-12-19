class AddLogoToTeams < ActiveRecord::Migration
  def change
  	add_attachment :teams, :logo
  end
end
