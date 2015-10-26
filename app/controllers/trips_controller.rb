require 'date'
require "#{ Rails.root }/lib/expedia_api"
include TripPlannerAPIs

class TripsController < ApplicationController
  before_action :require_login
  before_action :current_user

  LIMIT = 50

  def index
    user_trips = current_user.trips
    @trips = user_trips.lattest.limit(LIMIT)
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    @trip.image_url = 'pin.png'
    if @trip.save
      render partial: 'new_trip'
    else
      @error = "Please, check the dates you enter"
      render partial: 'error', :status => 400
    end
  end

  def show
    @items = Wardrobe.all
    @task = Task.new
    @trip = Trip.find(params[:trip_id])
    destination = @trip.destination
    start_date = @trip.start_date
    end_date = @trip.end_date
    @popular_things_todo = ExpediaAPI.things_todo(destination, start_date, end_date)
    @tasks = @trip.tasks.lattest
    @calendar = draw_calendar(@trip)
  end

  def destroy
    trip = Trip.find(params[:trip_id])
    trip.destroy
    render nothing: true
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :start_date, :end_date)
  end

  def draw_calendar(trip)
    trip_beginning = trip.start_date
    trip_end = trip.end_date

    start_date = Date.strptime(trip_beginning, "%Y-%m-%d")
    end_date = Date.strptime(trip_end, "%Y-%m-%d")

    calendar = []
    date = start_date

    while date <= end_date do
      calendar.push(date.strftime("%Y-%m-%d"))
      date += 1
    end
    return calendar
  end
end
