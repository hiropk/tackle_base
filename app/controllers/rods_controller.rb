class RodsController < ApplicationController
  before_action :check_user_activation
  before_action :reject_direct_access
  before_action :set_current_user
  before_action :set_rods, only: :index
  before_action :set_rod, only: %i[ show edit update destroy ]

  def index
  end

  # GET /rods/1 or /rods/1.json
  def show
  end

  # GET /rods/new
  def new
    @rod = Rod.new
  end

  # GET /rods/1/edit
  def edit
  end

  # POST /rods or /rods.json
  def create
    @rod = Rod.new(rod_params.merge({ user: @current_user }))

    respond_to do |format|
      if @rod.save
        format.html { redirect_to root_path, notice: "ロッドを作成しました。" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rods/1 or /rods/1.json
  def update
    respond_to do |format|
      if @rod.update(rod_params)
        format.html { redirect_to @rod, notice: "ロッドを更新しました。" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rods/1 or /rods/1.json
  def destroy
    @rod.destroy!

    respond_to do |format|
      format.html { redirect_to rods_path, status: :see_other, notice: "ロッドを削除しました。" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rod
      @rod = Rod.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def rod_params
      params.expect(rod: [ :name, :brand, :length, :fishing_type, :power, :reel_type, :min_weight, :max_weight, :purchase_date, :price, :notes ])
    end
end
