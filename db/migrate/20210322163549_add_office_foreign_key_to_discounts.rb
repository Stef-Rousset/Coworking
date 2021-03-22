class AddOfficeForeignKeyToDiscounts < ActiveRecord::Migration[6.1]
  def change
    add_reference :discounts, :office, null: false, foreign_key: true
  end
end
