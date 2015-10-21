require 'date'
require "#{ Rails.root }/lib/expedia_api"
include TripPlannerAPIs

class TripsController < ApplicationController
  before_action :user_signed_in?
  # before_action :current_user
  LIMIT = 10

  def index
    user_trips = current_user.trips
    @trips = user_trips
    # @trips = user_trips.lattest.limit(LIMIT)
    @trip = Trip.new
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    @trip.image_url = 'pin.png'
    if @trip.save
      destination = @trip.destination
      start_date = @trip.start_date
      end_date = @trip.end_date
      @popular_things_todo = ExpediaAPI.things_todo(destination, start_date, end_date)
      @calendar = draw_calendar(@trip)
      render 'trip'
      # redirect_to user_trips_path(current_user.user_name)
      # render 'show'
    else
      flash[:error] = "Error ocured"
      redirect_to :back
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @tasks = @trip.tasks
    @calendar = draw_calendar(@trip)
    render "show_test"
    # redirect_to expedia_results_path(@trip.destination, @trip.start_date, @trip.end_date, @trip.id)
  end

  # def search
  #   search = params.require(:search).permit(:query)
  #   query = search[:query]
  #   if !search[:query].empty?
  #     @query_result = Trip.where(destination: search[:query])
  #   end
  # end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    # trip.unassociate_user
    # redirect_to user_trips_path(current_user.user_name)
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :start_date, :end_date)
  end

  def user_signed_in?
    if !session[:user_id]
      redirect_to root_path
    end
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