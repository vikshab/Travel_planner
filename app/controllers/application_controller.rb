class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :require_login
  helper_method :current_user
  helper_method :draw_calendar
  helper_method :total_budget

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

    def total_budget(expances_per_day)
      i = 0
      total_sum = []

      while i < expances_per_day.length do
        if expances_per_day[i]["date"] != nil
          total_sum.push(expances_per_day[i]["total"].to_i)
        end
          i += 1
      end
      return total_sum.inject(0, :+)
    end
end
