class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account. It may take 1 minute to receive the email."
      redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def index
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
  end




  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

end
