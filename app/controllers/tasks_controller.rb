class TasksController < ApplicationController
  before_action :require_login
  before_action :current_user

  def index
    @trip = Trip.find(params["trip"])
    # raise
    @tasks = @trip.tasks
    # user = User.find(params[:id])
    # @tasks = user.tasks
  end

  # def new
  #   @task = Task.new
  # end

  def create
    @task = Task.new(task_params)
    @task.trip_id = params["trip"]

    if @task.save
      flash[:success] = "Saved"
      # redirect_to :back
      # @popular_things_todo = ExpediaAPI.things_todo(destination, start_date, end_date)
      # @calendar = draw_calendar(@trip)
      # render 'show_test'
    else
      flash[:error] = "Error ocured"
      redirect_to :back
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @title = task_params[:task][:title]
    @description = task_params[:task][:title]
    @date = task_params[:task][:date]
    @task.update(title: "#{@title}", description: "#{@description}", date: "#{@date}")
    @task.save
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :date)
  end

end
