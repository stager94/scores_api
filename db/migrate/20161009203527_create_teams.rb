class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :title_ru
      t.string :title_en
      t.string :title_de
      t.string :full_title_ru
      t.string :full_title_en
      t.string :full_title_de
      t.string :sofa_score_slug
      t.integer :sofa_score_id
      t.references :stadium, index: true, foreign_key: true
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
