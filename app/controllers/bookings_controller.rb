class BookingsController < ApplicationController

  def create
    @office = Office.find(params[:office_id]) #pour la redirection
    @building = @office.building #pour la redirection
    #@booking = Booking.new(booking_params.to_h.merge({ office_id: params[:office_id], user_id: current_user.id }))
    #@booking.office = @office
    #@booking.user = current_user
    if Booking.create!(booking_params.to_h.merge({ office_id: params[:office_id], user_id: current_user.id}))
      flash[:notice] = 'Réservation enregistrée !'
      redirect_to building_offices_path(@building)
    else
      render 'office/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user_id, :office_id, :price,
     service_bookings_attributes: [:id, :service_id, :booking_id, :quantity])
  end
end
