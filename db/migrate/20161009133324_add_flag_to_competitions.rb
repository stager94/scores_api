class AddFlagToCompetitions < ActiveRecord::Migration
  def change
  	add_attachment :competitions, :flag
  end
end
