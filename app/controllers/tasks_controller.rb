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
      render partial: 'shared/error', :status => 400
    end
  end

  def create_from_things_todo
    title = params[:activity_title]
    description = "Price: $" + params[:activity_price] + ". Duration: " + params[:activity_duration]
    date = Date.today.to_s
    trip_id = params[:trip_id]
    @task = Task.new(title: title, description: description, date: date, trip_id: trip_id)

    if @task.save
      render partial: 'new_task'
    else
      @error = "Couldn't add this activity to tasks"
      render partial: 'shared/error', :status => 400
    end
  end

  def show
    if Task.find(params[:task_id])
      @task = Task.find(params[:task_id])
      render partial: 'show_task'
    else
      @error = "Task is not found"
      render partial: 'shared/error', :status => 400
    end
  end

  def edit
    @task = Task.find(params[:task_id])
    render partial: 'edit_task'
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
    else
      @error = "Make sure date is entered"
      render partial: 'shared/error', :status => 400
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
