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
    @big_bookings_price = Building.big_bookings_price

    # vue user
    @bookings = Booking.where(user_id: current_user.id)

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Buildings_stats.xlsx"'
      }
      format.pdf {
      html = render_to_string(:partial => "building_stats.html.erb", :layout => false)
      kit = PDFKit.new(html, :orientation => 'Landscape')
      kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/pages/dashboard.scss"
      send_data(kit.to_pdf, :filename => "building_stats.pdf", :type => "application/pdf", :disposition => 'attachment')
      }
    end
  end

  # def building_stats_as_pdf
  #   @number_of_offices_per_building = Building.total_number_of_offices
  #   @num_of_books = Building.total_number_of_bookings
  #   @private_books = Building.private_bookings
  #   @cowork_books = Building.cowork_bookings
  #   @seven_days_bookings = Building.seven_days_ago_bookings
  # end

end
