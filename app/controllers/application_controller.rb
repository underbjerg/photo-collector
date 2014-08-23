class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def signed_in?
    !!current_user
  end
  
  def check_public_access
    require_user # if ENV['PRIVATE'] == 'true'
  end
  
  def require_user
    unless current_user
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_path
      return false
    end
    return true
  end
  
end
