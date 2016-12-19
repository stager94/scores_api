ActiveAdmin.register Incident do

  filter :incident_type, as: :select
  filter :incident_class, as: :select

  index do
    selectable_column
    column :event
    column :team
    column :time
    column :added_time
    column :incident_type
    column :incident_class
    column :is_home
    actions
  end

end
