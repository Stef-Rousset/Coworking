class AddOfficeTypeColumnToOffices < ActiveRecord::Migration[6.1]
  def change
    add_column :offices, :office_type, :integer
  end
end
