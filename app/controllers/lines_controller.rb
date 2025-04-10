class LinesController < ApplicationController
  before_action :set_line, only: %i[ show edit update destroy ]

  # GET /lines or /lines.json
  def index
    @lines = Line.all
  end

  # GET /lines/1 or /lines/1.json
  def show
  end

  # GET /lines/new
  def new
    @line = Line.new
  end

  # GET /lines/1/edit
  def edit
  end

  # POST /lines or /lines.json
  def create
    @line = Line.new(line_params)

    respond_to do |format|
      if @line.save
        format.html { redirect_to @line, notice: "Line was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lines/1 or /lines/1.json
  def update
    respond_to do |format|
      if @line.update(line_params)
        format.html { redirect_to @line, notice: "Line was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lines/1 or /lines/1.json
  def destroy
    @line.destroy!

    respond_to do |format|
      format.html { redirect_to lines_path, status: :see_other, notice: "Line was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def line_params
      params.expect(line: [ :user_id, :name, :brand, :pe_rating, :length, :strand_count, :marker, :price, :purchase_date, :notes ])
    end
end
