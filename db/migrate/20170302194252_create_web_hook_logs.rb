class CreateWebHookLogs < ActiveRecord::Migration
  def change
    create_table :web_hook_logs do |t|
      t.references :web_hook_resource, index: true, foreign_key: true
      t.json :params
      t.text :response
      t.integer :status

      t.timestamps null: false
    end
  end
end
