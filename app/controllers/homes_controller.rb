require "open-uri"

class HomesController < ApplicationController
  before_action :set_tackles, only: :index
  before_action :set_rods, only: :index
  before_action :set_reels, only: :index
  before_action :set_lines, only: :index
  before_action :set_leaders, only: :index
  before_action :check_user_activation
  before_action :check_profile_setup, only: :index
  before_action :set_calendar_date, only: :index

  def index
  end

  def help
  end

  private

  def set_calendar_date
    year = params[:year]&.to_i || Date.current.year
    month = params[:month]&.to_i || Date.current.month
    @start_date = Date.new(year, month, 1)
  end

  def check_profile_setup
    return unless @current_user
    return if @current_user.profile&.setup_completed?

    redirect_to edit_user_profile_path(@current_user), alert: "プロフィールの設定を完了してください。"
  end
end
