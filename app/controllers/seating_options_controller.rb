class SeatingOptionsController < ApplicationController
  before_action :authenticate_business!
  before_action :set_seating_option, :validation, only: %i[ show edit update destroy ]

  # GET /seating_options or /seating_options.json
  def index
    @seating_options = current_business.seating_options
  end

  # GET /seating_options/1 or /seating_options/1.json
  def show
  end

  # GET /seating_options/new
  def new
    @seating_option = SeatingOption.new
  end

  # GET /seating_options/1/edit
  def edit
  end

  # POST /seating_options or /seating_options.json
  def create
    @seating_option = current_business.seating_options.build(seating_option_params)

    respond_to do |format|
      if @seating_option.save
        format.html { redirect_to seating_option_url(@seating_option), notice: "Seating option was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seating_options/1 or /seating_options/1.json
  def update
    respond_to do |format|
      if @seating_option.update(seating_option_params)
        format.html { redirect_to seating_option_url(@seating_option), notice: "Seating option was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seating_options/1 or /seating_options/1.json
  def destroy
    @seating_option.destroy!

    respond_to do |format|
      format.html { redirect_to seating_options_url, notice: "Seating option was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_seating_option
    @seating_option = SeatingOption.find(params[:id])
  end

  def validation
    redirect_to current_business unless @seating_option.business == current_business
  end

  # Only allow a list of trusted parameters through.
  def seating_option_params
    params.require(:seating_option).permit(:name)
  end
end
