class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in(user)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "Welcome back, #{user.name}."
        redirect_back_or root_url
      else
        flash[:warning] = "Account not activated. Check your email for activation link"
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Email or Password is incorrect"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:info] = "You have been logged out."
    redirect_to root_url
  end
end
