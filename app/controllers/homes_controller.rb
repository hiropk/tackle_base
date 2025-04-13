class HomesController < ApplicationController
  def index
    @search_rods = Rod.ransack(params[:q])
    @search_rods.sorts = "id desc" if @search_rods.sorts.empty?
    @rods = @search_rods.result.page(params[:page])
    @rods.where(user: @current_user)

    @lines = Line.page(params[:page])
    @lines.where(user: @current_user)
  end
end
