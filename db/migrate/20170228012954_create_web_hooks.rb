class CreateWebHooks < ActiveRecord::Migration
  def change
    create_table :web_hooks do |t|
      t.string :url
      t.boolean :is_enabled

      t.timestamps null: false
    end
  end
end
