class CreateStadia < ActiveRecord::Migration
  def change
    create_table :stadia do |t|
      t.string :title_ru
      t.string :title_en
      t.string :title_de
      t.integer :capacity
      t.string :city

      t.timestamps null: false
    end
  end
end
