class ChangeProtocolDefaultInEvents < ActiveRecord::Migration
  def change
    change_column_default :events, :protocol, ''
  end
end
