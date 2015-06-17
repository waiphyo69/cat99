class SessionsController < ApplicationController

  def new
    if self.current_user
      redirect_to cats_url
    else
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if login!(@user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token
      current_user.save!
    end
    session[:session_token] = nil
    render :new
  end

end
