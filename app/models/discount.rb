class Discount < ApplicationRecord
  belongs_to :office

  validates :amount, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def discount_period
    self.start_date..self.end_date
  end
end
