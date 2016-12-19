class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :title_ru
      t.string :title_en

      t.timestamps null: false
    end
  end
end
