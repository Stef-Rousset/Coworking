class AddPlacesNumberColumnToOffices < ActiveRecord::Migration[6.1]
  def change
    add_column :offices, :places_number, :integer
  end
end
