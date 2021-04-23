class Building < ApplicationRecord

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  has_many_attached :photos

  has_many :offices, dependent: :destroy


  private

  def self.join_with_offices
    offices = Office.arel_table
     joins(:offices)
  end

  def self.join_with_offices_and_bookings
    join_with_offices.merge(Office.join_with_bookings)
  end

  def self.total_number_of_offices
    buildings = Building.arel_table
    offices = Office.arel_table
    join_with_offices
    .group(buildings[:id])
    .pluck(offices[:id].count)
  end

  def self.total_number_of_bookings
    bookings = Booking.arel_table
    query_with_offices_and_bookings
    .pluck(bookings[:id].count)
  end

  def self.private_bookings
    bookings = Booking.arel_table
    query_with_offices_and_bookings
    .merge(Office.private_office)
    .pluck(bookings[:id].count)
  end

  def self.cowork_bookings
    bookings = Booking.arel_table
    query_with_offices_and_bookings
    .merge(Office.cowork_office)
    .pluck(bookings[:id].count)
  end

  def self.query_with_offices_and_bookings
    buildings = Building.arel_table
    group(buildings[:id])
    .join_with_offices_and_bookings
    .order(buildings[:id].asc)
  end

  def self.seven_days_ago_bookings
    query_with_offices_and_bookings
    .merge(Booking.seven_days_ago).size
  end

  def self.number_of_clients
    bookings = Booking.arel_table
    query_with_offices_and_bookings
    .pluck(bookings[:user_id].uniq.count)
  end

  def self.total_number_of_services
    service_bookings = ServiceBooking.arel_table
    query_with_offices_and_bookings
    .merge(Booking.join_with_service_bookings)
    .pluck(service_bookings[:quantity].sum)
  end

  def self.number_of_services(name)
    service_bookings = ServiceBooking.arel_table
    query_with_offices_and_bookings
    .merge(Booking.join_with_service_bookings)
    .merge(ServiceBooking.join_service_with_name(name))
    .pluck(service_bookings[:quantity].sum)
  end
end


