class OfficesController < ApplicationController
  before_action :set_office, only: [:show, :edit, :update, :destroy]
  before_action :set_building, only: [:show, :edit, :update, :destroy]

  def index
    @building = Building.find(params[:building_id])
    @offices = @building.offices
    @offices = @offices.filter_by_price(params[:office_price_min], params[:office_price_max]) if params[:office_price_min].present? || params[:office_price_max].present?
    @offices = @offices.filter_by_discount(params[:discount]) if params[:discount].present?
    @offices = @offices.filter_by_available_date(params[:date]) if params[:date].present?

    @discount = Discount.new
  end

  def show
    @booking = Booking.new
    @booking.service_bookings.build #4.times { @booking.service_bookings.build }
    @services = Service.all
    @discounts = Discount.where(office_id: @office.id)
  end

  def new
    @building = Building.find(params[:building_id])
    @office = Office.new
  end

  def create
    @building = Building.find(params[:building_id]) #pour la redirection
    #@office = Office.new(office_params.to_h.merge({building_id: params[:building_id]}))
    #@office.building = @building
    if Office.create!(office_params.to_h.merge({building_id: params[:building_id]}))
      redirect_to building_offices_path(@building)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @office.update(office_params)
    redirect_to building_offices_path(@building)
  end

  def destroy
    @office.destroy
    redirect_to building_offices_path(@building)
  end

  private

  def set_office
    @office = Office.find(params[:id])
  end

  def set_building
    @building = Office.find(params[:id]).building
  end

  def office_params
    params.require(:office).permit(:price, :places_number, :name, :office_type, :building_id)
  end

end
