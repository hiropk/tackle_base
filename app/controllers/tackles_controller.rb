class TacklesController < ApplicationController
  before_action :reject_direct_access
  before_action :set_current_user
  before_action :set_tackle, only: %i[ show edit update destroy ]
  before_action :set_tackles, only: :index
  before_action :set_rods, only: :new
  before_action :set_reels, only: :new

  # GET /tackles or /tackles.json
  def index
  end

  # GET /tackles/1 or /tackles/1.json
  def show
  end

  # GET /tackles/new
  def new
    @tackle = Tackle.new
  end

  # GET /tackles/1/edit
  def edit
  end

  # POST /tackles or /tackles.json
  def create
    @tackle = Tackle.new(tackle_params.merge({ user: @current_user }))

    respond_to do |format|
      if @tackle.save
        format.html { redirect_to root_path, notice: "タックルを作成しました。" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tackles/1 or /tackles/1.json
  def update
    respond_to do |format|
      if @tackle.update(tackle_params)
        format.html { redirect_to @tackle, notice: "タックルを更新しました。" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tackles/1 or /tackles/1.json
  def destroy
    @tackle.destroy!

    respond_to do |format|
      format.html { redirect_to tackles_path, status: :see_other, notice: "タックルを削除しました。" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tackle
      @tackle = Tackle.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tackle_params
      params.expect(tackle: [ :user_id, :name, :rod_id, :reel_id, :knot, :leader_id, :notes ])
    end
end
