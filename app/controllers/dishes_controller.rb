class DishesController < ApplicationController
  before_action :authenticate_business!, :set_group, :validation
  before_action :set_dish, only: %i[ show edit update destroy ]

  # GET /dishes or /dishes.json
  def index
    @dishes = @group.dishes.all
  end

  # GET /dishes/1 or /dishes/1.json
  def show
  end

  # GET /dishes/new
  def new
    @dish = Dish.new
    @dish.serve_sizes.build
  end

  # GET /dishes/1/edit
  def edit
  end

  # POST /dishes or /dishes.json
  def create
    @dish = @group.dishes.build(dish_params)

    respond_to do |format|
      if @dish.save
        format.html { redirect_to dish_url(@dish, group_id: @group.id), notice: "Dish was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dishes/1 or /dishes/1.json
  def update
    respond_to do |format|
      if @dish.update(dish_params)
        format.html { redirect_to dish_url(@dish, group_id: @group.id), notice: "Dish was successfully updated." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1 or /dishes/1.json
  def destroy
    @dish.destroy!

    respond_to do |format|
      format.html { redirect_to dishes_url(group_id: @group.id), notice: "Dish was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dish
    @dish = Dish.find(params[:id])
  end

  def set_group
    @group = Group.find_by(id: params[:group_id])
  end
  
  def validation
    redirect_to menus_url unless @group && @group.business == current_business
  end

  # Only allow a list of trusted parameters through.
  def dish_params
    params.require(:dish).permit(:name, :description, serve_sizes_attributes: [:id, :name, :price, :_destroy])
  end
end
