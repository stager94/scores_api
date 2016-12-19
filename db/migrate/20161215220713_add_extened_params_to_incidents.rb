class AddExtenedParamsToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :extended_params, :json
  end
end
