class AddTitleDeToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :title_de, :string
  end
end
