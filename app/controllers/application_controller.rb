class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :require_login
  helper_method :current_user
  helper_method :draw_calendar

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_login
      redirect_to root_path unless session[:user_id]
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
