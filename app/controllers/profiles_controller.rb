class ProfilesController < ApplicationController
  before_action :set_user
  before_action :set_profile, only: [ :show, :edit, :update ]

  def new
    @profile = @user.build_profile
  end

  def create
    @profile = @user.build_profile(profile_params.merge({ user: @current_user }))
    if @profile.save
      redirect_to user_profile_path(@user), notice: "\u30D7\u30ED\u30D5\u30A3\u30FC\u30EB\u3092\u4F5C\u6210\u3057\u307E\u3057\u305F\u3002"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to user_profile_path(@user), notice: "\u30D7\u30ED\u30D5\u30A3\u30FC\u30EB\u3092\u66F4\u65B0\u3057\u307E\u3057\u305F\u3002"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_profile
    @profile = @user.profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :bio)
  end
end
