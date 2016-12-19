class AddSofaScoreIdToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :sofa_score_id, :integer
    add_index :regions, :sofa_score_id
  end
end
