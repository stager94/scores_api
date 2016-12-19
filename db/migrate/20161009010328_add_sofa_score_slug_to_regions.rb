class AddSofaScoreSlugToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :sofa_score_slug, :string
    add_index :regions, :sofa_score_slug
  end
end
