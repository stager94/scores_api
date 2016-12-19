class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :title_ru
      t.string :title_en
      t.string :title_de
      t.string :sofa_score_slug
      t.integer :sofa_score_id
      t.integer :regions_count, null: false, default: 0
      t.integer :competitions_count, null: false, default: 0

      t.timestamps null: false
    end
    add_index :sports, :sofa_score_id
  end
end
