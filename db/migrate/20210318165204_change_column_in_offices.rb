class ChangeColumnInOffices < ActiveRecord::Migration[6.1]
  def change
    change_column :offices, :price, :float
  end
end
