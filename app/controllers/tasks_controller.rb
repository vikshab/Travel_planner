class TasksController < ApplicationController
  before_action :require_login
  before_action :current_user

  def create
    @task = Task.new(task_params)
    @task.trip_id = params[:trip_id]

    if @task.save
      render partial: 'new_task'
    else
      @error = "Make sure you enter the title and date"
      render partial: 'error', :status => 400
    end
  end

  def show
    if Task.find(params[:task_id])
      @task = Task.find(params[:task_id])
      render partial: 'show_task'
    else
      @error = "Task is not found"
      render partial: "error", :status => 400
    end
  end

  def edit
    # if Task.find(params[:task_id])
      @task = Task.find(params[:task_id])
      # render json: @task
      render partial: 'edit_task'
    # else
      # @error = "Edit form error"
      # render partial: 'error'
    # end
  end

  def update
    @task = Task.find(params[:task_id])
    @title = params[:task][:title]
    @description = params[:task][:description]
    @date = params[:task][:date]
    @task.trip_id = params[:trip_id]
    @task.update(title: "#{@title}", description: "#{@description}", date: "#{@date}", trip_id: "#{@task.trip_id}")

    if @task.save
      render partial: 'updated_task'
      # render nothing: true
      # render json: "success"
    else
      @error = "Make sure date is entered"
      render partial: 'error', :status => 400
    end
  end


  def destroy
    task = Task.find(params[:task_id])
    task.destroy
    render nothing: true
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :date)
  end

end
