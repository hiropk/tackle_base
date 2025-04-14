class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
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

  def set_rods
    @search_rods = Rod.ransack(params[:q])
    @search_rods.sorts = "id desc" if @search_rods.sorts.empty?
    @rods = @search_rods.result.page(params[:page])
    @rods.where(user: @current_user)
  end

  def set_lines
    @search_lines = Line.ransack(params[:q])
    @search_lines.sorts = "id desc" if @search_lines.sorts.empty?
    @lines = @search_lines.result.page(params[:page])
    @lines.where(user: @current_user)
  end
end
