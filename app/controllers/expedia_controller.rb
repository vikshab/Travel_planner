require "#{ Rails.root }/lib/expedia_api"
include TripPlannerAPIs

class ExpediaController < ApplicationController
  def results
    @trip = Trip.find(params[:format])
    # @destination = trip.destination
    # start_date = trip.start_date
    # end_date = trip.end_date
    @destination = params[:destination]
    start_date = params[:start_date]
    end_date = params[:end_date]
    @results = ExpediaAPI.things_todo(@destination, start_date, end_date)
    # redirect_to 'trip'
  end
end
