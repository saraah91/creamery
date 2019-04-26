class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :adminsNmanagers_abilities, only: [:create, :new]
  before_action :destroyNupdate_rights, only: [:destroy, :update, :edit]
  before_action :showing_rights, only: [:show]


  # GET /shifts
  # GET /shifts.json
  def index
    on_duty = current_user.employee.current_assignment
    if current_users_role == "admin"
      @shifts = Shift.all
    elsif current_users_role == "manager" && on_duty
      @shifts = Shift.for_store(on_duty.store_id)
    elsif current_users_role == "employee" && on_duty
      @shifts = Shift.for_employee(current_user.id)
    end
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
  end

  # GET /shifts/new
  def new
      @shift = Shift.new
  end

  # GET /shifts/1/edit
  def edit
  end

  # POST /shifts
  # POST /shifts.json
  def create
      @shift = Shift.new(shift_params)

      respond_to do |format|
        if @shift.save
          format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
          format.json { render :show, status: :created, location: @shift }
        else
          format.html { render :new }
          format.json { render json: @shift.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
      respond_to do |format|
        if @shift.update(shift_params)
          format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
          format.json { render :show, status: :ok, location: @shift }
        else
          format.html { render :edit }
          format.json { render json: @shift.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    if @current_user.role == "admin"
      @shift.destroy
      respond_to do |format|
        format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes)
    end
    
    def adminsNmanagers_abilities
      unless current_users_role == "admin" || current_users_role == "manager"
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'You are not authorised to do that' }
          format.json { head :no_content }
        end
      end
    end

    def destroyNupdate_rights
      manager = @shift.assignment && current_user.employee.current_assignment && current_user.employee.current_assignment.store_id == @shift.assignment.store_id
      unless current_users_role == "admin" || ( current_users_role == "manager" && manager)
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'You are not authorised to do that' }
          format.json { head :no_content }
        end
      end
    end
    
    def showing_rights
      manager = @shift.assignment && current_user.employee.current_assignment && current_user.employee.current_assignment.store_id == @shift.assignment.store_id
      unless current_users_role == "admin" || (current_users_role == "employee" && @shift.employee == current_user.employee) ||(@role == "manager" && current_user.employee.current_assignment && @shift.assignment && manager )
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'You are not authorised to do that' }
          format.json { head :no_content }
        end
      end
    end
    
    
end
