class HomesController < ApplicationController
  before_action :set_rods, only: :index
  before_action :set_lines, only: :index

  def index
  end
end
