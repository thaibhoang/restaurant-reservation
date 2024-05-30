# class ServeSizesController < ApplicationController
#   before_action :set_serve_size, only: %i[ show edit update destroy ]

#   # GET /serve_sizes or /serve_sizes.json
#   def index
#     @serve_sizes = ServeSize.all
#   end

#   # GET /serve_sizes/1 or /serve_sizes/1.json
#   def show
#   end

#   # GET /serve_sizes/new
#   def new
#     @serve_size = ServeSize.new
#   end

#   # GET /serve_sizes/1/edit
#   def edit
#   end

#   # POST /serve_sizes or /serve_sizes.json
#   def create
#     @serve_size = ServeSize.new(serve_size_params)

#     respond_to do |format|
#       if @serve_size.save
#         format.html { redirect_to serve_size_url(@serve_size), notice: "Serve size was successfully created." }
#         format.json { render :show, status: :created, location: @serve_size }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @serve_size.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /serve_sizes/1 or /serve_sizes/1.json
#   def update
#     respond_to do |format|
#       if @serve_size.update(serve_size_params)
#         format.html { redirect_to serve_size_url(@serve_size), notice: "Serve size was successfully updated." }
#         format.json { render :show, status: :ok, location: @serve_size }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @serve_size.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /serve_sizes/1 or /serve_sizes/1.json
#   def destroy
#     @serve_size.destroy!

#     respond_to do |format|
#       format.html { redirect_to serve_sizes_url, notice: "Serve size was successfully destroyed." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_serve_size
#       @serve_size = ServeSize.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def serve_size_params
#       params.require(:serve_size).permit(:name, :price, :dish_id)
#     end
# end
