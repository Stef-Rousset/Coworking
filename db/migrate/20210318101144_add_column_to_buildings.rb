class AddColumnToBuildings < ActiveRecord::Migration[6.1]
  def change
    add_column :buildings, :description, :text
  end
end
