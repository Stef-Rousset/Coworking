class RemoveColumnFromOffices < ActiveRecord::Migration[6.1]
  def change
    remove_column :offices, :space
  end
end
