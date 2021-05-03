class AddPriceColumnToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :price, :float
  end
end
