class WardrobesController < ApplicationController
  before_action :require_login
  before_action :current_user

  def create
    @wardrobe = Wardrobe.new(wardrobe_params)
    @trip = Trip.find(params[:trip_id])
    @wardrobe.trips << @trip
    @wardrobe.date = params[:date]
    if @wardrobe.save
      render partial: 'new_wardrobe'
    else
      @error = "Enter wardrobe item"
      render partial: 'error', :status => 400
    end
  end

  def remove_wardrobe_item_from_trip
    wardrobe_item = Wardrobe.find(params[:wardrobe_id])
    trip = wardrobe_item.trips.find(params[:trip_id])
    if trip
      wardrobe_item.trips.delete(trip)
    end
    render nothing: true
  end

  private

  def wardrobe_params
    params.require(:wardrobe).permit(:name, :quantity)
  end
end
