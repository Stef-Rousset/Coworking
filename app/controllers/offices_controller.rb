class OfficesController < ApplicationController
  before_action :set_office, only: [:edit,:update, :destroy]
  before_action :set_building, only: [:edit, :update, :destroy]

  def index
    @building = Building.find(params[:building_id])
    @offices = @building.offices
  end

  def new
    @building = Building.find(params[:building_id])
    @office = Office.new
  end

  def create
    @building = Building.find(params[:building_id])
    @office = Office.new(office_params)
    @office.building = @building
    if @office.save!
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
    params.require(:office).permit(:price, :places_number, :name, :building_id)
  end

end
