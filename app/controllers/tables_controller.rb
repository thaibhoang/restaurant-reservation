class TablesController < ApplicationController
  before_action :authenticate_business!
  before_action :set_table, :validation, only: %i[ show edit update destroy ]
  before_action :validate_seating_option, :set_seating_option, only: %i[create update]
  before_action :set_seating_option, :set_bulk_variable, :validate_bulk_create_params, only: :bulk_create
  

  # GET /tables or /tables.json
  def index
    @tables = current_business.tables
    @seating_options = current_business.seating_options
  end

  # GET /tables/1 or /tables/1.json
  def show
  end

  # GET /tables/new
  def new
    if params[:message] == "cancel"
      render partial: "tables/cancel_form"
      return
    end

    @table = Table.new
    @seating_options = SeatingOption.all

    @bulk_form = params[:bulk]
  end

  # GET /tables/1/edit
  def edit
  end

  # POST /tables or /tables.json
  def create
    @table = current_business.tables.build(table_params)

    respond_to do |format|
      if @table.save
        format.html { redirect_to table_url(@table), notice: "Table was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def bulk_create
    if Table.create_bulk(@number_of_tables, @starting_number, @seats, @seating_option, current_business)
      redirect_to seating_options_url
    else
      flash.notice = "Failed to create tables"
      redirect_to seating_options_url
    end
  end

  # PATCH/PUT /tables/1 or /tables/1.json
  def update
    @old_seating_option = @table.seating_option
    respond_to do |format|
      if @table.update(table_params)
        format.html { redirect_to table_url(@table), notice: "Table was successfully updated." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1 or /tables/1.json
  def destroy
    @table.destroy!

    respond_to do |format|
      format.html { redirect_to tables_url, notice: "Table was successfully destroyed." }
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    def set_seating_option
      @seating_option = SeatingOption.find_by(id: params[:table][:seating_option_id])
    end

    def validation
      redirect_to current_business unless @table.business == current_business
    end

    def validate_seating_option
      @seating_option = SeatingOption.find(params[:table][:seating_option_id])
      redirect_to current_business unless @seating_option.business == current_business
    end

    def set_bulk_variable
      @number_of_tables = params[:table][:number_of_tables].to_i
      @starting_number = params[:table][:starting_number].to_i
      @seats = params[:table][:seats].to_i
    end

    def validate_bulk_create_params
      unless Table.validate_bulk_base_info(params[:table][:number_of_tables],
                                           params[:table][:starting_number],
                                           params[:table][:seats])
        flash.notice = "Invalid attributes"
        redirect_to seating_options_url
      end
    end

    # Only allow a list of trusted parameters through.
    def table_params
      params.require(:table).permit(:number, :seats, :seating_option_id)
    end
end
