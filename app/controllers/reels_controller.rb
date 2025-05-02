class ReelsController < ApplicationController
  before_action :require_login
  before_action :reject_direct_access
  before_action :set_reels, only: :index
  before_action :set_reel, only: %i[ show edit update destroy ]

  # GET /reels or /reels.json
  def index
  end

  # GET /reels/1 or /reels/1.json
  def show
  end

  # GET /reels/new
  def new
    @reel = Reel.new
  end

  # GET /reels/1/edit
  def edit
  end

  # POST /reels or /reels.json
  def create
    @reel = Reel.new(reel_params.merge({ user: @current_user }))

    respond_to do |format|
      if @reel.save
        format.html { redirect_to @reel, notice: "リールを作成しました。" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reels/1 or /reels/1.json
  def update
    respond_to do |format|
      if @reel.update(reel_params)
        format.html { redirect_to @reel, notice: "リールを更新しました。" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reels/1 or /reels/1.json
  def destroy
    @reel.destroy!

    respond_to do |format|
      format.html { redirect_to reels_path, status: :see_other, notice: "リールを削除しました。" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reel
      @reel = Reel.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def reel_params
      params.expect(reel: [ :user_id, :name, :brand, :reel_type, :gear_type, :line_id, :price, :purchase_date, :notes ])
    end
end
