class UsersController < ApplicationController
  before_action :current_user
  before_action :user_exist?, only: [:show, :search]

  def new
    if !session[:user_id]
      @user = User.new
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to "/login"
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :phone)
  end

  def user_exist?
    if current_user
      if User.where(user_name: params[:user]).any? && current_user[:user_name] != params[:user]
        flash[:error] = "You are not '" + params[:user].capitalize + "'"
        redirect_to "/" + current_user[:user_name] + "/dashboard"
      elsif !User.where(user_name: params[:user]).any?
        flash[:error] = "The user '" + params[:user].capitalize + "' does not exist"
        redirect_to "/" + current_user[:user_name] +"/dashboard"
      end
    else
      redirect_to root_path
    end
  end
end
