class SessionsController < ApplicationController
  before_filter :require_user, :only => :destroy
  
  def new
    if params[:code]
      @code = params[:code]
      if @code == "bryllup"
        @authorized = true
      else
        @message = "Forkert kode!"
      end
      
    end
  end
  
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
