class ChangeColumnNameInOffices < ActiveRecord::Migration[6.1]
  def change
    rename_column :offices, :type, :space
  end
end
