class BuildingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  before_action :set_building, only: [:edit, :update, :destroy]

  def show
    @building = Building.includes(:offices).find(params[:id])
    @offices = @building.offices
  end

  def new
    @building = Building.new
  end

  def create
    #@building = Building.new(building_params)
    if Building.create!(building_params)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @building.update(building_params)
    redirect_to dashboard_path
  end

  def destroy
    @building.destroy
    redirect_to dashboard_path
  end

  private

  def set_building
    @building = Building.find(params[:id])
  end

  def building_params
    params.require(:building).permit(:name, :address, :description, photos: [])
  end

end
