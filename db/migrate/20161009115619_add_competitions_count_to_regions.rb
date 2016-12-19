class AddCompetitionsCountToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :competitions_count, :integer

    Region.reset_column_information
    Region.find_each do |r|
    	Region.update_counters r.id, competitions_count: r.competitions.length
    end
  end
end
