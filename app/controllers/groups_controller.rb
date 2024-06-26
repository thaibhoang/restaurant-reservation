class GroupsController < ApplicationController
  before_action :authenticate_business!, :set_menu, :validation
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    @groups = @menu.groups.all
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    if params[:message] == "cancel"
      render partial: "groups/cancel_form"
      return
    end
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = @menu.groups.build(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group, menu_id: @menu.id), notice: "Group was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group, menu_id: @menu.id), notice: "Group was successfully updated." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to groups_url(menu_id: @menu.id), notice: "Group was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  def set_menu
    @menu = Menu.find_by(id: params[:menu_id])
  end

  def validation
    redirect_to menus_url unless @menu && @menu.business == current_business
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name)
  end

end
