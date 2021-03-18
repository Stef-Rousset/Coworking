class OfficesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_office, only: [:edit, :destroy]

  def index
    @building = Building.find(params[:building_id])
    @offices = @building.offices
  end

  def new
    @office = Office.new
  end

  def create
    @office = Office.new(office_params)
    if @office.create!
      redirect_to building_offices_path
    else
      render :new
    end
  end

  def destroy
    @office.destroy
    redirect_to building_offices_path
  end

  private

  def set_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.require(:office).permit(:price, :space, :name, :building_id)
  end

end
