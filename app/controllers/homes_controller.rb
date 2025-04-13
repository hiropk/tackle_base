class HomesController < ApplicationController
  def index
    @search = Rod.ransack(params[:q])
    @search.sorts = "id desc" if @search.sorts.empty?
    @rods = @search.result.page(params[:page])
    @rods.where(user: @current_user)

    @lines = Line.page(params[:page])
    @lines.where(user: @current_user)
  end
end
