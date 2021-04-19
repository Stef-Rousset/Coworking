class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :office
  has_many :service_bookings, dependent: :destroy, inverse_of: :booking
  has_many :services, through: :service_bookings
  accepts_nested_attributes_for :service_bookings, reject_if: :all_blank
                                                   # reject_if: lambda {|attributes| attributes['quantity'].blank?}

  validates :start_date, presence: true
  validates :end_date, presence: true

  # scope :cafe_count, -> { joins(:services).where("name = ?", "café") }
  # scope :the_count, -> { joins(:services).where("name = ?", "thé") }
  # scope :impression_count, -> { joins(:services).where("name = ?", "impression") }
  # scope :scan_count, -> { joins(:services).where("name = ?", "scan") }

  scope :service_count, -> (name) { joins(:services).where("name = ?", name).count }
  scope :total_number_of_services, -> { joins(:services).count }
  scope :last_seven_days_bookings, -> { where(created_at: (Time.now.midnight - 7.day)..Time.now.midnight).count }

  def dates_booked
    self.end_date ? self.start_date..self.end_date : self.start_date..self.start_date
    # dates = [self.start_date]
    # while dates.last <= (self.end_date - 1)
    #   dates << (dates.last + 1)
    # end
    # return dates
  end

  # def booking_price
  #   office_price_per_day = self.office.price * 60 * 7
  #   service_price = []
  #   self.services.each do |service|
  #     service_price << service.price
  #   end
  #   discount_days = self.dates_booked.select{ |date|
  #     self.office.discounts.each do |discount|
  #       discount.discount_period.include?(date)
  #     end
  #   }
  #   if discount_days.empty?
  #     return office_price_per_day + service_price.sum
  #   else
  #     self.office.discounts.each do |discount|
  #       office_price_with_discount = office_price_per_day * discount.amount
  #       number_of_days_with_discount
  #     end
  #     total_price_with_discount = (office_price_per_day * discount.amount * discount_days.length)
  #                                + (office_price_per_day * (self.dates_booked.length - discount_days.length))
  #     return office_price_with_discount +  service_price.sum
  #   end
  # end

end
