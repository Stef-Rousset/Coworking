class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @buildings = Building.all.shuffle.first(3)
  end

  def dashboard
    # vue admin
    # charger tous les buildings avec eager-load des offices, et des bookings de chq office,
    # et des services de chq booking
    @buildings = Building.all.includes(offices: { bookings: [:services] })

    @number_of_offices_per_building = Building.total_number_of_offices
    @num_of_books = Building.total_number_of_bookings
    @private_books = Building.private_bookings
    @cowork_books = Building.cowork_bookings
    @seven_days_bookings = Building.seven_days_ago_bookings
    @num_of_clients = Building.number_of_clients
    @num_of_services = Building.total_number_of_services
    @num_of_cafes = Building.number_of_services('café')
    @num_of_thes = Building.number_of_services('thé')
    @num_of_impressions = Building.number_of_services('impression')
    @num_of_scans = Building.number_of_services('scan')
    @two_services_booked = Building.two_services_booked

    # vue user
    @bookings = Booking.where(user_id: current_user.id)

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Buildings_stats.xlsx"'
      }
    end
  end
end
