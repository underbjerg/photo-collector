class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  helper_method :signed_in?

  before_action :set_locale
 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def signed_in?
    !!current_user && current_user.knows_code
  end
  
  def check_public_access
    require_user # if ENV['PRIVATE'] == 'true'
  end
  
  def require_user
    if current_user && current_user.knows_code
      return true
    elsif current_user
      redirect_to enter_code_path
      return false
    else
      #flash[:notice] = "You must be logged in to access this page"
      redirect_to login_path
      return false
    end
  end
  
  private
  def set_locale
    if params[:locale] #locale override?
      I18n.locale = params[:locale]
    else
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end 
  
  
end
