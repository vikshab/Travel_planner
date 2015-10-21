class SessionsController < ApplicationController

  def new
    if session[:user_id]
      redirect_to root_path
    end
  end

  def create
    user = User.find_by_user_name(params[:session][:user_name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_trips_path(user.user_name)
    else
      flash[:error] = "Incorrect Username or password, please try again"
      render :new
    end
  end

  def create_facebook
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to user_trips_path(user.user_name)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
