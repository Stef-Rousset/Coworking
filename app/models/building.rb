class Building < ApplicationRecord

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  has_many_attached :photos

  has_many :offices, dependent: :destroy


  private

  #methode avec un left_outer_join (alias left_joins) pour gerer les champs vides
  def self.total_number_of_offices
    buildings = Building.arel_table
    offices = Office.arel_table
    left_joins(:offices)
    .group(buildings[:id])
    .order(buildings[:id].asc)
    .pluck(offices[:id].count)
  end

  def self.total_number_of_bookings
    buildings = Building.arel_table
    bookings = Booking.arel_table
    left_joins(offices: :bookings)
    .group(buildings[:id])
    .order(buildings[:id].asc)
    .pluck(bookings[:id].count)
  end

  def self.private_bookings
    buildings = Building.arel_table
    bookings = Booking.arel_table
    offices = Office.arel_table
    group(buildings[:id])
    .order(buildings[:id].asc)
    .left_joins(offices: :bookings)
    .where(offices[:office_type].eq(1).or(bookings[:id].eq(nil)))
    .pluck(bookings[:id].count)
  end

  def self.cowork_bookings
    buildings = Building.arel_table
    bookings = Booking.arel_table
    offices = Office.arel_table
    group(buildings[:id])
    .order(buildings[:id].asc)
    .left_joins(offices: :bookings)
    .where(offices[:office_type].eq(2).or(bookings[:id].eq(nil)))
    .pluck(bookings[:id].count)
  end

  def self.seven_days_ago_bookings
    buildings = Building.arel_table
    bookings = Booking.arel_table
    offices = Office.arel_table
    group(buildings[:id])
    .order(buildings[:id].asc)
    .left_joins(offices: :bookings)
    .where(bookings[:created_at].gteq(Time.now.end_of_day - 7.day).or(bookings[:id].eq(nil)))
    .pluck(bookings[:id].count)
  end

  def self.number_of_clients
    buildings = Building.arel_table
    bookings = Booking.arel_table
    distinct_user_bookings = Booking.where(bookings[:user_id].gteq(1).or(bookings[:id].eq(nil)))
    group(buildings[:id])
    .order(buildings[:id].asc)
    .left_joins(offices: :bookings)
    .where(bookings[:user_id].gteq(1).or(bookings[:id].eq(nil)))
    .select(bookings[:user_id]).distinct.count

  end

  def self.total_number_of_services
    buildings = Building.arel_table
    service_bookings = ServiceBooking.arel_table
    group(buildings[:id])
    .order(buildings[:id].asc)
    .left_joins(offices: { bookings: :service_bookings })
    .where(service_bookings[:quantity].gteq(1).or(service_bookings[:id].eq(nil)))
    .pluck(service_bookings[:quantity].sum)
  end

  def self.two_services_booked
    buildings = Building.arel_table
    service_bookings = ServiceBooking.arel_table
    group(buildings[:id])
    .order(buildings[:id])
    .left_joins(offices: { bookings: :service_bookings })
    .where(service_bookings[:service_id].gteq(2).or(service_bookings[:id].eq(nil)))
    .pluck(service_bookings[:id].count)
  end

  def self.number_of_services(name)
    buildings = Building.arel_table
    service_bookings = ServiceBooking.arel_table
    services = Service.arel_table
    group(buildings[:id])
    .order(buildings[:id])
    .left_joins(offices: { bookings: { service_bookings: :service } })
    .where(services[:name].eq(name).or(service_bookings[:id].eq(nil)))
    .pluck(service_bookings[:quantity].sum)
  end

  def self.list_of_offices(name)
    buildings = Building.arel_table
    offices = Office.arel_table
    where(buildings[:name].eq(name))
    .left_outer_joins(:offices)
    .pluck(offices[:name])
  end

end


