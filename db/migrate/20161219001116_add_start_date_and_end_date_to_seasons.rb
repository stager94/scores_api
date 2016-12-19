class AddStartDateAndEndDateToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :start_date, :datetime
    add_column :seasons, :end_date, :datetime
  end
end
