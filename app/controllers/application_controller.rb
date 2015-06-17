class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def login!(user)
    if user
      user.reset_session_token
      user.save!
      session[:session_token] = user.session_token
      @current_user = user
    else
      return nil
    end
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end


end
