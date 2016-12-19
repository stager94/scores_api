class AddDatesLoadedToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :dates_loaded, :boolean, default: false
  end
end
