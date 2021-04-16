class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @buildings = Building.all.shuffle.first(3)
  end

  def dashboard
    # charger tous les buildings avec eager-load des offices, et des bookings de chq office,
    # et des services de chq booking
    @buildings = Building.all.includes(offices: { bookings: [:services] })
    @bookings = Booking.where(user_id: current_user.id)
  end
end
