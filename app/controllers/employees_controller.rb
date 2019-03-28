class EmployeesController < ApplicationController
    
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.alphabetical
  end
  
  # this is special action we've created to give us the list of managers
  def managers
      # should I do this?
  #  @employees = Employee.proposed.by_category.paginate(:page => params[:page]).per_page(10)
  end
  
  def show
  end

  def new
    @employee = Employee.new
  end

  #find the person by id and hence display their info 
  def edit
      @employee = Employee.find(params[:id])
  end

  def create
      # shoud employee_params be in the model?
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: "#{@employee.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee, notice: "#{@employee.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_url
  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from users (potential hackers), but rather only allow the white list through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :active => [] )
    end


end
