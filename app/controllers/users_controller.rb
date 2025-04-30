class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Please check your email to activate your account."
      redirect_to root_path
    else
      render :new
    end
  end

  def activate
    @user = User.find_by(activation_token: params[:token])
    if @user && !@user.activated
      @user.activate
      redirect_to login_path, notice: "Your account has been activated!"
    else
      redirect_to root_path, alert: "Invalid or expired activation link."
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
