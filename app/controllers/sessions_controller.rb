class SessionsController < ApplicationController
  #before_filter :require_user, :only => [:destroy]
  
  @@passcode = "bobler"
  
  def new
  end
  
  def failure
    flash[:alert] = "Login fejlede"
    #puts "alert before redirect: " + flash[:alert].to_s
    redirect_to login_path
  end
  
  def enter_code
    @code = params[:code]
    puts "Code / passcode: " + @code.to_s + "/" + @@passcode.to_s
    if @code
      if @code == @@passcode
        current_user.update_attribute(:knows_code, true)
        redirect_to root_path
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
