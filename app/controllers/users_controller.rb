class UsersController < ApplicationController
  before_action :current_user

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
end
