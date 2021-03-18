class RemoveColumnFromBuildings < ActiveRecord::Migration[6.1]
  def change
    remove_column :buildings, :city
  end
end
