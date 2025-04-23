class LogsController < ApplicationController
  before_action :set_log, only: %i[ show edit update destroy ]

  # GET /logs or /logs.json
  def index
    @logs = Log.all
  end

  # GET /logs/1 or /logs/1.json
  def show
  end

  # GET /logs/new
  def new
    @log = Log.new
  end

  # GET /logs/1/edit
  def edit
  end

  # POST /logs or /logs.json
  def create
    @log = Log.new(log_params)

    respond_to do |format|
      if @log.save
        format.html { redirect_to @log, notice: "釣行日誌を作成しました。" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logs/1 or /logs/1.json
  def update
    respond_to do |format|
      if @log.update(log_params)
        format.html { redirect_to @log, notice: "釣行日誌を更新しました。" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1 or /logs/1.json
  def destroy
    @log.destroy!

    respond_to do |format|
      format.html { redirect_to logs_path, status: :see_other, notice: "釣行日誌を削除しました。" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def log_params
      params.expect(log: [ :fishing_date, :start_time, :end_time, :area, :fishing_guide_boat, :menu, :notes, :other ])
    end
end
