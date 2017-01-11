class AddSimpleTitleToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :simple_title_en, :string
  end
end
