class AddSportReferencesToRegions < ActiveRecord::Migration
  def change
    add_reference :regions, :sport, index: true, foreign_key: true
  end
end
