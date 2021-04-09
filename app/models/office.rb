class Office < ApplicationRecord
  belongs_to :building
  has_many :discounts, dependent: :destroy
  has_many :bookings
  has_many :users, through: :bookings
  has_many :service_bookings, through: :bookings

  validates :price, presence: true
  validates :places_number, presence: true, numericality: { only_integer: true }
  validates :name, presence: true

  enum office_type: { privates: 1, coworks: 2 }
end
