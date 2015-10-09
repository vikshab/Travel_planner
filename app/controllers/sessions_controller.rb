class SessionsController < ApplicationController
  def destroy
    # session[:user_id] = nil
    # flash[:success] = "Signed out!"
    # redirect_to root_path
  end

  def create
    # @user = User.find(id)
    # session[:user_id] = @user.id
    # flash[:success] = "You've been signed in, #{ @user.name }!"
    # redirect_to root_url
  end

  def create_facebook
    auth = request.env["omniauth.auth"]
    # au_user = AuUser.find_by_provider_and_uid(auth["provider"], auth["uid"]) || AuUser.create_with_omniauth(auth)
    # session[:user_id] = au_user.id
    # flash[:success] = "You've been signed in, #{ au_user.name }!"
    # redirect_to root_url
  end
end
