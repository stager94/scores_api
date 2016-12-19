ActiveAdmin.register Season do

  filter :competition_id
  filter :dates_loaded
  filter :is_active

  index do
    selectable_column
    column :year
    column :competition
    column :is_active
    column :start_date
    column :end_date
    column :dates_loaded
    column :events_last_load_timestamp do |s|
      Time.at s.events_last_load_timestamp rescue "-"
    end
    actions
  end

end
