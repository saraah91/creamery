require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
    setup do
      create_contexts
      #@employee = employees(:one)
    end

    teardown do
      remove_contexts
    end

  test "should get index" do
    get employees_url
    assert_response :success
  end
  
  test "should get manager" do
    get managers_employees_url
    assert_response :success
  end

  test "should get admins" do
    get admins_employees_url
    assert_response :success
  end

  test "should get regulars" do
    get regulars_employees_url
    assert_response :success
  end

  test "should get inactive employees" do
    get inactive_employees_url
    assert_response :success
  end
  
  test "should get active employees" do
    get active_employees_url
    assert_response :success
  end
  
  test "should get employees 18 years or older" do
    get is_18_or_older_employees_url
    assert_response :success
  end

  test "should get employees younger than 18" do
    get younger_than_18_employees_url
    assert_response :success
  end


  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { active: @employee.active, date_of_birth: @employee.date_of_birth, first_name: @employee.first_name, last_name: @employee.last_name, phone: @employee.phone, role: @employee.role, ssn: @employee.ssn } }
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: { employee: { active: @employee.active, date_of_birth: @employee.date_of_birth, first_name: @employee.first_name, last_name: @employee.last_name, phone: @employee.phone, role: @employee.role, ssn: @employee.ssn } }
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end
end
