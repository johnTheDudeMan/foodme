class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		login(user)
  		redirect_to root_path
  		flash[:success] = "Boomshakalaka!!!!"
  	else
  		flash.now[:danger] = "Email or Password is incorrect"
  		render 'sessions/new'
  	end
  end

  def destroy
  	reset_session
  	redirect_to root_path
  end
end
