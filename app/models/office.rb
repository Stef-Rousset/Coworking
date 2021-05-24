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

  scope :total_bookings, -> { joins(:bookings).count }
  scope :privates_bookings, -> { where(office_type: 1).joins(:bookings).count }
  scope :coworks_bookings, -> { where(office_type: 2).joins(:bookings).count }

  #scope :filter_by_discount, -> (discount) { joins(:discounts) }
  #scope :filter_by_price, -> (office_price_min, office_price_max) { where("price >= ? AND price <= ?", (office_price_min.to_f / 60), (office_price_max.to_f / 60))}


  def self.filter_by_discount(discount_min = 0, discount_max = 0)
    discounts = Discount.arel_table
    joins(:discounts)
    .where(discounts[:amount].gteq(discount_min.to_f / 100)
      .and(discounts[:amount].lteq(discount_max.to_f / 100))
      .and(discounts[:end_date]).gteq(Date.today))
    .distinct
    # joins(:discounts).distinct
  end

  def self.filter_by_price(office_price_min = 0, office_price_max = 0)
    where(price: (office_price_min.to_f / 60)..(office_price_max.to_f / 60))
  end

  def self.filter_by_available_date(date)
    bookings = Booking.arel_table
    offices = Office.arel_table

    left_joins(:bookings)
    .where(bookings[:id].eq(nil).or(bookings[:start_date].gt(date)).or(bookings[:end_date].lt(date)))
    .distinct

  end

end
