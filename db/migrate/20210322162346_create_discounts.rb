class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.float :amount
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
