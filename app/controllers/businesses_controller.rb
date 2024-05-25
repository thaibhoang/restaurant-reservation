class BusinessesController < ApplicationController
  before_action :authenticate_business!, :set_business, :owner_only
  def show
  end

  private

  def set_business
    @business = Business.find(params[:id])
  end

  def owner_only
    return if @business == current_business

    flash[:notice] = "You can only see your own restaurant's admin page"
    redirect_to current_business
  end
end
