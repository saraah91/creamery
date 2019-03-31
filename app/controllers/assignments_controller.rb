class AssignmentsController < ApplicationController
  
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  def current
    @assignments = Assignment.current
  end
  
  def past
    @assignments= Assignment.past
  end
  
  def by_store
    @assignments= Assignment.by_store
  end

  def by_employee
    @assignments= Assignment.by_employee
  end
  
  def chronological
    @assignments= Assignment.chronological
  end
  
  def for_store
    @assignments= Assignment.for_store
  end

  def for_employee
    @assignments = Assignment.for_employee
  end
  
  def for_pay_level
    @assignments = Assignment.for_pay_level
  end
  
  def for_role
    @assignments = Assignment.for_role
  end
  
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
      redirect_to @assignment, notice: "#{@assignment.id} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @assignment.update(assignment_params)
      redirect_to @assignment, notice: "#{@assignment.id} was revised in the system."
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
      params.require(:assignment).permit(:store_id, :employee_id, :start_date, :end_date, :pay_level)
    end
    

end
