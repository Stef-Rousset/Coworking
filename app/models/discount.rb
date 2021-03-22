class Discount < ApplicationRecord
  belongs_to :office

  validates :amount, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

end
