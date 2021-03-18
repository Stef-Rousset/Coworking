class BuildingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :set_building, only: [:show, :destroy]

  def show
    @offices = @building.offices
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(building_params)
    if @building.save!
      redirect_to building_path(@building)
    else
      render :new
    end
  end

  def destroy
    @building.destroy
    redirect_to root_path
  end

  private

  def set_building
    @building = Building.includes(:offices).find(params[:id])
  end

  def building_params
    params.require(:building).permit(:name, :address, :description, photos: [])
  end

end
