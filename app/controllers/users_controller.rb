class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @kitchen = @user.kitchen
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_kitchen
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account. It may take 1 minute to receive the email."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your account settings were successfully updated."
      redirect_to @user
    else
      @user.avatar = @user.avatar.retrieve_from_store!(@user.avatar.identifier)
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "#{user.name} was deleted!"
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :blurb)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

end
