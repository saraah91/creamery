class AssignmentsController < ApplicationController
  
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  def index
    @assignments = Assignment.all
  end
  
  def show
  end

  def new
    @assignment = Assignment.new
  end

  def edit
      @assignment = Assignment.find(params[:id])
  end

  def create
      # shoud assignment_params be in the model?
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      redirect_to @assignment, notice: "#{@assignment.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @assignment.update(assignment_params)
      redirect_to @assignment, notice: "#{@assignment.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_url
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from users (potential hackers), but rather only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:store_id, :employee_id, :start_date, :end_date, :pay_level => [])
    end
    

end
