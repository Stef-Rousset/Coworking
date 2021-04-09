class Service < ApplicationRecord
  has_many :service_bookings
  has_many :bookings, through: :service_bookings

  validates :name, presence: true
  validates :price, presence: true

end
