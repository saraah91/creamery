class StoreFlavorsController < ApplicationController
  before_action :set_store_flavor, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :adminsNmanagers_abilities, only: [:destroy, :index, :show]  

  def adminsNmanagers_abilities
      manager_on_duty = current_users_role == "manager" && current_user.employee.current_assignment && @shift_job.shift && @shift_job.shift.assignment
      manager_store_id = manager_on_duty && @shift_job.shift.assignment.store_id && @shift_job.shift.assignment.store_id == current_user.employee.current_assignment.store_id
      unless current_users_role == "admin" || manager_store_id
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'You are not authorized to view this information/perform this action' }
          format.json { head :no_content }
        end
      end
  end
  
  # GET /store_flavors
  # GET /store_flavors.json
  def index
      @store_flavors = StoreFlavor.all
  end

  # GET /store_flavors/1
  # GET /store_flavors/1.json
  def show
  end

  # GET /store_flavors/new
  def new
      @store_flavor = StoreFlavor.new
  end

  # GET /store_flavors/1/edit
  def edit
  end

  # POST /store_flavors
  # POST /store_flavors.json
  def create
      @store_flavor = StoreFlavor.new(store_flavor_params)

      respond_to do |format|
        if @store_flavor.save
          format.html { redirect_to @store_flavor, notice: 'Store flavor was successfully created.' }
          format.json { render :show, status: :created, location: @store_flavor }
        else
          format.html { render :new }
          format.json { render json: @store_flavor.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /store_flavors/1
  # PATCH/PUT /store_flavors/1.json
  def update
      respond_to do |format|
        if @store_flavor.update(store_flavor_params)
          format.html { redirect_to @store_flavor, notice: 'Store flavor was successfully updated.' }
          format.json { render :show, status: :ok, location: @store_flavor }
        else
          format.html { render :edit }
          format.json { render json: @store_flavor.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /store_flavors/1
  # DELETE /store_flavors/1.json
  def destroy
      @store_flavor.destroy
      respond_to do |format|
        format.html { redirect_to store_flavors_url, notice: 'Store flavor was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_flavor
      @store_flavor = StoreFlavor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_flavor_params
      params.require(:store_flavor).permit(:store_id, :integer, :flavor_id, :integer)
    end
end
