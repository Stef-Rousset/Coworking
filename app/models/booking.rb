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

  # def self.with_min_two_services
    # bookings = Booking.arel_table
    # left_joins(:service_bookings).group(bookings[:id]).having('count(booking_id) > 1')
    # .count =>
    # {115=>3, 108=>2, 116=>3, 114=>2, 110=>2, 109=>2, 111=>2, 122=>3}
    # .count.keys =>
    #[115, 108, 116, 114, 110, 109, 111, 122]
  # end
end
