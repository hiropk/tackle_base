class LogsController < ApplicationController
  before_action :check_user_activation
  before_action :set_log, only: %i[ show edit update destroy ]
  before_action :set_logs, only: :index

  # GET /logs or /logs.json
  def index
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
    @log = Log.new(log_params.merge({ user: @current_user }))

    tackle_ids = params.dig(:log, :tackle_ids)&.uniq || []
    if tackle_ids.empty? || !all_tackles_exist?(tackle_ids)
      @log.errors.add(:base, "タックルの選択に不備があります。")
      flash[:alert] = @log.errors.full_messages.join(" / ")
    end

    respond_to do |format|
      if @log.errors.empty? && @log.save
        tackle_ids.each do |tackle_id|
          TackleSelection.create!(log: @log, tackle_id: tackle_id)
        end
        format.html { redirect_to @log, notice: "釣行日誌を作成しました。" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logs/1 or /logs/1.json
  def update
    tackle_ids = params.dig(:log, :tackle_ids)&.uniq || []
    if tackle_ids.empty? || !all_tackles_exist?(tackle_ids)
      @log.errors.add(:base, "タックルの選択に不備があります。")
      flash[:alert] = @log.errors.full_messages.join(" / ")
    end

    respond_to do |format|
      if @log.errors.empty? && @log.update(log_params)
        tackle_ids.each do |tackle_id|
          TackleSelection.create!(log: @log, tackle_id: tackle_id)
        end
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
    def set_logs
      set_fishing_gear("log")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def log_params
      params.require(:log).permit(:fishing_date, :area, :fishing_guide_boat, :menu, :notes, :other)
    end

    def all_tackles_exist?(ids)
      return false if ids.empty?

      Tackle.where(id: ids).pluck(:id).sort == ids.map(&:to_i).uniq.sort
    end
end
