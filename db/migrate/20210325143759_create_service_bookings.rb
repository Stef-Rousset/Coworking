class CreateServiceBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :service_bookings do |t|
      t.references :service, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
