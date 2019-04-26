class ShiftJobsController < ApplicationController
  before_action :set_shift_job, only: [:show, :edit, :update, :destroy]
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


  # GET /shift_jobs
  # GET /shift_jobs.json
  def index
      @shift_jobs = ShiftJob.all
  end

  # GET /shift_jobs/1
  # GET /shift_jobs/1.json
  def show
  end

  # GET /shift_jobs/new
  def new
      @shift_job = ShiftJob.new
  end

  # GET /shift_jobs/1/edit
  def edit
  end

  # POST /shift_jobs
  # POST /shift_jobs.json
  def create
      @shift_job = ShiftJob.new(shift_job_params)

      respond_to do |format|
        if @shift_job.save
          format.html { redirect_to @shift_job, notice: 'Shift job was successfully created.' }
          format.json { render :show, status: :created, location: @shift_job }
        else
          format.html { render :new }
          format.json { render json: @shift_job.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /shift_jobs/1
  # PATCH/PUT /shift_jobs/1.json
  def update
      respond_to do |format|
        if @shift_job.update(shift_job_params)
          format.html { redirect_to @shift_job, notice: 'Shift job was successfully updated.' }
          format.json { render :show, status: :ok, location: @shift_job }
        else
          format.html { render :edit }
          format.json { render json: @shift_job.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /shift_jobs/1
  # DELETE /shift_jobs/1.json
  def destroy
      @shift_job.destroy
      respond_to do |format|
        format.html { redirect_to shift_jobs_url, notice: 'Shift job was successfully destroyed.' }
        format.json { head :no_content }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift_job
      @shift_job = ShiftJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_job_params
      params.require(:shift_job).permit(:shift_id, :integer, :job_id, :integer)
    end
end
