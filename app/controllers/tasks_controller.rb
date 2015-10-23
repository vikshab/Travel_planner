class TasksController < ApplicationController
  before_action :require_login
  before_action :current_user

  def create
    @task = Task.new(task_params)
    @task.trip_id = params[:id]

    if @task.save
      render partial: 'new_task'
    else
      @error = "Make sure you enter the title and date"
      render partial: 'error', :status => 400
    end
  end

  def show
    @task = Task.find(params[:id])
    # render json: @task
    render partial: 'show_task'
  end


  # def edit
  #   @task = Task.find(params[:id])
  # end

  def update
    @task = Task.find(params[:id])
    @title = task_params[:task][:title]
    @description = task_params[:task][:title]
    @date = task_params[:task][:date]
    @task.update(title: "#{@title}", description: "#{@description}", date: "#{@date}")
    @task.save
  end


  def destroy
    task = Task.find(params[:id])
    task.destroy
    render nothing: true
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :date)
  end

end
