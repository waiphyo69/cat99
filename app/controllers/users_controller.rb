class UsersController < ApplicationController

  def index
  end

  def new
    unless self.current_user
      @user = User.new
      session[:session_token] = nil
      render :sign_up
    else
      redirect_to cats_url
    end
  end

  def create
    @user = User.new(user_params)
    @user.reset_session_token
    if @user.save!
      login!(@user)
      redirect_to cats_url
    else
      render :sign_up
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    render :show
  end

  private
  def user_params
    params[:user].permit(:user_name, :password)
  end

end
