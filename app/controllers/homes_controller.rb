class HomesController < ApplicationController
  before_action :set_tackles, only: :index
  before_action :set_rods, only: :index
  before_action :set_reels, only: :index
  before_action :set_lines, only: :index
  before_action :set_leaders, only: :index
  before_action :check_user_activation

  def index
  end
end
