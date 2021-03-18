class AddColumnToOffices < ActiveRecord::Migration[6.1]
  def change
    add_column :offices, :name, :string
  end
end
