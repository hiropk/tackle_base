class RodsController < ApplicationController
  before_action :set_rod, only: %i[ show edit update destroy ]
  before_action :set_current_user

  # GET /rods or /rods.json
  def index
    @search = Rod.ransack(params[:q])
    @search.sorts = "id desc" if @search.sorts.empty?
    @rods = @search.result.page(params[:page])
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
        format.html { redirect_to @rod, notice: "Rod was successfully created." }
        format.json { render :show, status: :created, location: @rod }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rod.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rods/1 or /rods/1.json
  def update
    respond_to do |format|
      if @rod.update(rod_params)
        format.html { redirect_to @rod, notice: "Rod was successfully updated." }
        format.json { render :show, status: :ok, location: @rod }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rod.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rods/1 or /rods/1.json
  def destroy
    @rod.destroy!

    respond_to do |format|
      format.html { redirect_to rods_path, status: :see_other, notice: "Rod was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rod
      @rod = Rod.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def rod_params
      params.expect(rod: [ :name, :brand, :length, :fishing_type, :power, :reel_type, :min_weight, :max_weight, :purchase_date, :notes ])
    end
end
