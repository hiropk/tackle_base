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
end
