class ApplicationController < ActionController::Base
  include Authentication
  before_action :set_current_user

  private

  def set_current_user
    @current_user = Current.user
  end

  def reject_direct_access
    unless request.referer.present?
      redirect_to new_session_path, alert: "直接アクセスは禁止されています。"
    end
  end

  def check_user_activation
    set_current_user if @current_user.nil?

    unless @current_user.activated
      redirect_to user_profile_path(@current_user), alert: "アカウントの有効化 によりアカウントの有効化を行なってください。"
    end
  end

  def set_fishing_gear(gear)
    value = instance_variable_set("@search_#{gear}s", to_class_name(gear).constantize.ransack(params[:q]))
    value.sorts = "id desc" if value.sorts.empty?
    instance_variable_set("@#{gear}s", value.result.page(params[:page]).where(user: @current_user))
  end

  def to_class_name(str)
    str.split("_").map(&:capitalize).join
  end

  def set_tackles
    set_fishing_gear("tackle")
  end

  def set_rods
    set_fishing_gear("rod")
  end

  def set_reels
    set_fishing_gear("reel")
  end

  def set_lines
    set_fishing_gear("line")
  end

  def set_leaders
    set_fishing_gear("leader")
  end
end
