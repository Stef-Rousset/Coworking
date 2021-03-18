class OfficesController < ApplicationController
  before_action :set_office, only: [:edit, :destroy]

  def index
    @offices = Office.all
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

  private

  def set_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.require(:office).permit(:price, :space, :building_id)
  end

end
