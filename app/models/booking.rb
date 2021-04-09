class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :office
  has_many :service_bookings, dependent: :destroy, inverse_of: :booking
  has_many :services, through: :service_bookings
  accepts_nested_attributes_for :service_bookings, reject_if: :all_blank
                                                   # reject_if: lambda {|attributes| attributes['quantity'].blank?}

  validates :start_date, presence: true
  validates :end_date, presence: true
end
