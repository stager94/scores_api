ActiveAdmin.register EventStatus do

  index do
    selectable_column
    id_column
    column :code
    column :type
    column :key
    column :is_finished
    column :is_interrupted
    column :in_process
    actions
  end

end
