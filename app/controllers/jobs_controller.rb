class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :admins_abilities, only: [:edit, :update, :destroy, :create, :new]
  
  def admins_abilities
      unless current_users_role == "admin"
        respond_to do |format|
        format.html { redirect_to jobs_url, notice: 'You are not authorized to view this information/perform this action' }
        format.json { head :no_content }
        end
      end
  end
  
  def admins_abilities
      unless current_users_role == "admin"
        respond_to do |format|
        format.html { redirect_to jobs_url, notice: 'You are not authorized to view this information/perform this action' }
        format.json { head :no_content }
        end
      end
  end
  
  # GET /jobs
  # GET /jobs.json
  def index
      @jobs = Job.alphabetical
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end
  
  def active
      @jobs = Job.active
  end  
  
  def inactive
      @jobs = Job.inactive
  end  

  # GET /jobs/new
  def new
      @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
      @job = Job.new(job_params)

      respond_to do |format|
        if @job.save
          format.html { redirect_to @job, notice: 'Job was successfully created.' }
          format.json { render :show, status: :created, location: @job }
        else
          format.html { render :new }
          format.json { render json: @job.errors, status: :unprocessable_entity }
       end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
      respond_to do |format|
        if @job.update(job_params)
          format.html { redirect_to @job, notice: 'Job was successfully updated.' }
          format.json { render :show, status: :ok, location: @job }
        else
          format.html { render :edit }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
      @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
    

    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:name, :string, :description, :text, :active, :boolean)
    end
    
end
