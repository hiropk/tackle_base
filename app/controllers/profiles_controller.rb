class ProfilesController < ApplicationController
  before_action :set_user
  before_action :set_profile, only: [ :show, :edit, :update ]

  def new
    @profile = @user.build_profile
  end

  def show; end

  def edit; end

  def update
    attributes = profile_params
    attributes.merge!({ fishing_areas: [] }) if attributes[:fishing_areas].nil?
    attributes.merge!({ interest_fishings: [] }) if attributes[:interest_fishings].nil?

    if @profile.update(attributes)
      redirect_to user_profile_path(@user), notice: "プロフィールを更新しました。"
    else
      render :edit, status: :unprocessable_entity
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
    params.require(:profile).permit(:first_name, :last_name, :residence, fishing_areas: [], interest_fishings: [])
  end
end
