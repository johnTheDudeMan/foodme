class PasswordResetsController < ApplicationController
  before_action :get_user,           only: [:edit, :update]
  before_action :valid_user,         only: [:edit, :update]
  before_action :check_expiration,   only: [:edit, :update]

  def new
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_password_reset_digest
      @user.send_password_reset_email
      email_delay = "It may take a minute for the email to arrive."
      flash[:info] = "Check your email for a link to reset your password. " + email_delay
      redirect_to root_url
    else
      flash.now[:danger] = "Email address could not be found. Check spelling"
      render 'new'
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:pw_reset_digest, nil)
      flash[:success] = "Your password successfully updated."
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:pw_reset, params[:id]))
        flash[:danger] = "Uh oh, the link you used is not valid."
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        redirect_to new_password_reset_path
        flash[:danger] = "Password reset link expired. Submit your email again for a new one."
      end
    end
end