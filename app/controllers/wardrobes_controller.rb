class WardrobesController < ApplicationController
  before_action :require_login
  before_action :current_user

  def create
    @wardrobe = Wardrobe.new(wardrobe_params)
    # @trip = Trip.find(params[:trip_id])
    @wardrobe.trip_id = params[:trip_id]
    @wardrobe.date = params[:date]
    if @wardrobe.save
      render partial: 'new_wardrobe'
    else
      @error = "Enter name"
      render partial: 'error', :status => 400
    end
  end


  private

  def wardrobe_params
    params.require(:wardrobe).permit(:name, :quantity)
  end
end
