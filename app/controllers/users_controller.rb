class UsersController < ApplicationController
  # before_action :user_exist?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # log_in(@user)
      # flash[:success]="Success"
      redirect_to "/login"
    else
      render 'new'
    end
  end

  def show
    if session[:user_id]
      @current_user = User.find(session[:user_id])
      # if session[:user_id] == @current_user
      #   @user = User.find(session[:user_id])
      # end
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :phone)
  end

  # def user_exist?
  #   if User.where(id: params[:id].to_s).any?
  #     show
  #   else
  #     flash[:error] = "This user does not exist"
  #     redirect_to root_path
  #   end
  # end
end
