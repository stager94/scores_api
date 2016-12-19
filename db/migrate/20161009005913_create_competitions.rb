class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :title_ru
      t.string :title_en
      t.string :title_de
      t.references :region, index: true, foreign_key: true
      t.integer :sofa_score_id, index: true
      t.string :sofa_score_slug, index: true

      t.timestamps null: false
    end
  end
end
