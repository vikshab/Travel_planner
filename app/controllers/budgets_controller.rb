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
      @total_budget = @budget["total"]
      render partial: 'new_budget'
    else
      @error = "Enter sum"
      render partial: 'shared/error', :status => 400
    end
  end

    def update
      @amount = Budget.find(params[:amount_id])
      # if params[:commit] == '+'
        total = (params[:budget][:total].to_i + params[:amount_total].to_i).to_s
      # elsif params[:commit] == '-'
        # total = (params[:amount_total].to_i - params[:budget][:total].to_i).to_s
      # end

      @amount.trip_id = params[:trip_id]
      @amount.update(total: "#{total}", trip_id: "#{@amount.trip_id}")
      trip = Trip.find(params[:trip_id])
      @total_budget = total_budget(trip.budgets)

      if @amount.save
        render json: {total_amount: @total_budget, amount: @amount["total"]}
      else
        @error = "Error"
        render partial: 'shared/error', :status => 400
      end
    end

  def destroy_amount_per_day
    @budget = Budget.find(params[:budget_id])
    trip = Trip.find(params[:trip_id])
    old_budget = @budget["total"]
    @total_budget = total_budget(trip.budgets) - old_budget
    @budget.destroy
    render json: {budget: old_budget, total_budget: @total_budget}
  end

  def destroy_budget
    trip = Trip.find(params[:trip_id])
    all_budgets = trip.budgets

    all_budgets.each do |budget|
      budget.destroy
    end
    @total_budget = "0"

    render json: @total_budget
  end

    private

    def budget_params
      params.require(:budget).permit(:total)
    end

end
