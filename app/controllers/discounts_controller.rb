class DiscountsController < ApplicationController
  before_action :set_office, only: [:create]

  def create
    @discount = Discount.new(discount_params)
    @discount.office = @office

    respond_to do |format|
      if @discount.save!
      #if Discount.create!(discount_params.to_h.merge({ office_id: params[:office_id]}))
        format.js
        #flash[:notice] = 'Réduction ajoutée !'
        #redirect_to building_offices_path(@office.building.id)
      else
        format.html { render :template => 'offices/index' }
      end
    end
  end

  def destroy
    @office = Discount.find(params[:id]).office #pour la redirection
    @discount = Discount.find(params[:id])
    @discount.destroy
    #flash[:notice] = 'Réduction supprimée !'
    #redirect_to building_offices_path(@office.building.id)
    respond_to do |format|
      format.html { redirect_to building_offices_path(@office.building.id) }
      format.js
    end

  end

  private

  def set_office
    @office = Office.find(params[:office_id])
  end

  def discount_params
    params.require(:discount).permit(:amount, :start_date, :end_date, :office_id)
  end
end
