class BudgetsController < ApplicationController
  before_action :require_login
  before_action :current_user

  def create
    @budget = Budget.new(budget_params)
    @budget.trip_id = params[:trip_id]
    @trip = Trip.find(params[:trip_id])
    @calendar = draw_calendar(@trip)
    if @budget.save
      @expances_per_day = []
      i=0
      while i <= @calendar.length do
        @expances_per_day.push(Budget.create(total: @budget["total"]/@calendar.length, trip_id: params[:trip_id], date: @calendar[i]))
        i += 1
      end
      # @expances_per_day = @budget["total"]/@calendar.length
      render partial: 'new_budget'
    else
      @error = "Enter sum"
      render partial: 'error', :status => 400
    end
  end

  def destroy
    budget = Budget.find(params[:budget_id])
    budget.destroy
    render nothing: true
  end

    private

    def budget_params
      params.require(:budget).permit(:total)
    end

end
