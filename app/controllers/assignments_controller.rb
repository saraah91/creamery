class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :admins_abilities, only: [:edit, :update, :destroy, :create, :new]
  before_action :showing_rights, only: [:show]
  before_action :logged_in_user
  before_action :showing_rights, only: [:show]

  def showing_rights
      admin = current_users_role== "admin"
      employee = current_users_role == "employee"
      manager = current_users_role == "manager" && @employee.current_assignment && @current_user.employee.current_assignment && @employee.current_assignment.store_id == @current_user.employee.current_assignment.store_id
      unless admin or employee or manager
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'You are not authorized to view this information/perform this action' }
          format.json { head :no_content }
        end
      end      
  end
  
  def admins_abilities
      unless current_users_role == "admin"
        respond_to do |format|
        format.html { redirect_to assignments_url, notice: 'You are not authorized to view this information/perform this action' }
        format.json { head :no_content }
        end
      end
  end
  
  def current
    if current_users_role == "admin"
      @assignments = Assignment.current
    elsif current_users_role == "manager"
      @assignments = Assignment.current.for_employee(@current_user.id).for_store(@current_user.id)
       #Assignment.for_store(current_user.employee.current_assignment.store_id)
    elsif current_users_role == "employee"
      @assignments = Assignment.current.for_employee(@current_user.id)
    end
  end
  
  def past
    if current_users_role == "admin"
      @assignments = Assignment.past
    elsif current_users_role == "manager"
      @assignments = Assignment.past.for_employee(@current_user.id).for_store(@current_user.id)
       #Assignment.for_store(current_user.employee.current_assignment.store_id)
    elsif current_users_role == "employee"
      @assignments = Assignment.past.for_employee(@current_user.id)
    end
  end
  
  def by_store
    if current_users_role == "admin"
      @assignments = Assignment.by_store
    end
  end

  def by_employee
    if current_users_role == "admin"
      @assignments = Assignment.by_employee
    elsif current_users_role == "manager"
      @assignments = Assignment.by_employee.for_employee(@current_user.id).for_store(@current_user.id)
    end
  end
  
  def chronological
    if current_users_role == "admin"
      @assignments = Assignment.chronological
    elsif current_users_role == "manager"
      @assignments = Assignment.for_store(current_user.employee.current_assignment.store_id).for_role("employee")

       #Assignment.for_store(current_user.employee.current_assignment.store_id)
    elsif current_users_role == "employee"
      @assignments = Assignment.chronological.for_employee(current_user.id)
    end
  end
  
  def for_store
    if current_users_role == "admin"
      @assignments = @assignments.for_store(params[:for_store]) if params[:for_store].present?
    end
  end

  def for_employee
    if current_users_role == "admin"
      @assignments = @assignments.for_employee(params[:for_employee]) if params[:for_employee].present?
    end
  end
  
  def for_pay_level
    if current_users_role == "admin"
      @assignments = @assignments.for_pay_level(params[:for_pay_level]) if params[:for_pay_level].present?
    end
  end
  
  def for_role
    if current_users_role == "admin"
      @assignments = @assignments.for_role(params[:for_role]) if params[:for_role].present?
    end
  end
  
  def index
    if current_users_role == "admin"
      @assignments = Assignment.all
    elsif current_users_role == "manager"
      @assignments = Assignment.for_store(current_user.employee.current_assignment.store_id).for_role(:employee)
       #Assignment.for_store(current_user.employee.current_assignment.store_id)
    elsif current_users_role == "employee"
      @assignments = Assignment.all.for_employee(current_user.id)
    end
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

