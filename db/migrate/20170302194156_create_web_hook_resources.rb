class CreateWebHookResources < ActiveRecord::Migration
  def change
    create_table :web_hook_resources do |t|
      t.string :url
      t.string :title
      t.boolean :is_enabled

      t.timestamps null: false
    end
  end
end
