class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :editing_rights, only: [:edit]
  before_action :admins_abilities, only: [:update, :destroy, :create, :new]
  before_action :logged_in_user
  before_action :index_rights, only: [:index]
  before_action :showing_rights, only: [:show]

  
  def showing_rights
      admin = current_users_role== "admin"
      if current_users_role == "employee"
        @employee = current_user.employee
      end
      manager = current_users_role == "manager" && @employee.current_assignment && current_user.employee.current_assignment && @employee.current_assignment.store_id == current_user.employee.current_assignment.store_id
      unless admin or manager
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'You are not authorized to view this information' }
          format.json { head :no_content }
        end
      end      
  end
  
  def index_rights
      unless current_users_role == "admin" || current_users_role == "manager"
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'You are not authorized to view this information/perform this action' }
          format.json { head :no_content }
        end
      end
  end
  
  def admins_abilities
      unless current_users_role == "admin"
        respond_to do |format|
        format.html { redirect_to root_url, notice: 'You are not authorized to view this information/perform this action' }
        format.json { head :no_content }
        end
      end
  end
  
  def editing_rights
    puts "hfkejlkhekljhdgjefk;djhgfkel;dkfjdgh,fkldkfjdhgjewokfjhgdeioifdhu"
      unless current_users_role == "admin" || @user == current_user
        respond_to do |format|
        format.html { redirect_to root_url, notice: 'You are not authorized to view this information/perform this action' }
        format.json { head :no_content }
        end
      end
  end

  
  def index
    if current_users_role == "admin"
      @employees = Employee.all
    elsif current_users_role == "manager" && current_user.employee.current_assignment
      @employees = Employee.regulars.for_store(current_user.employee.current_assignment.store_id)
       #Assignment.for_store(current_user.employee.current_assignment.store_id)
    end
#     @employees = Employee.managers
#     @employees = Employee.admins
#     @employees = Employee.regulars
#   # @employees = Employee.regulars.for_store(@current_user.employee.current_assignment.store_id)
#     @employees = Employee.inactive
#   # @employees = Employee.inactive.for_store(@current_user.employee.current_assignment.store_id)
#     @employees = Employee.active 
#     @employees = Employee.is_18_or_older
#     @employees = Employee.younger_than_18
# #   @employees = Employee.proper_name
  end
  
  def show
  end

  def new
      @employee = Employee.new
      @employee.build_user
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
      if User != nil
        user = User.find_by_employee_id(@employee.id)
        if user != nil
          user.destroy
        end
      end
      @employee.destroy
      redirect_to employees_url
  end
    
  def managers
      @employees = Employee.managers
  end
  
  def admins
      @employees = Employee.admins
  end
  
  def regulars
      @employees = Employee.regulars
  end
  
  def inactive
      @employees = Employee.inactive
  end
  
  def active
      @employees = Employee.active
  end
  
  def is_18_or_older
      @employees = Employee.is_18_or_older
  end
  
  def younger_than_18
      @employees = Employee.younger_than_18
  end
    
  def proper_names
      @employees = Employee.all
  end
  
  # def noinfo
  #   redirect_to(employee_noinfo_path)
  # end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from users (potential hackers), but rather only allow the white list through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :active, user_attributes: [:id, :email, :password])
    end
    


end
