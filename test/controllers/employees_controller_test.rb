require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
    setup do
      create_employees
      #@employee = employees(:one)
    end

    teardown do
      remove_employees
    end

  test "should get index" do
    get employees_url
    assert_response :success
  end
  
  test "should get manager" do
    get '/employees/managers'
    assert_response :success
  end

  test "should get admins" do
    get '/employees/admins'
    assert_response :success
  end

  test "s/hould get regulars" do
    get '/employees/regulars'
    assert_response :success
  end

  test "should get inactive employees" do
    get '/employees/inactive'
    assert_response :success
  end
  
  test "should get active employees" do
    get '/employees/active'
    assert_response :success
  end
  
  test "should get employees 18 years or older" do
    get '/employees/is_18_or_older'
    assert_response :success
  end

  test "should get employees younger than 18" do
    get '/employees/younger_than_18'
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { active: @ed.active, date_of_birth: @ed.date_of_birth, first_name: @ed.first_name, last_name: @ed.last_name, phone: @ed.phone, role: @ed.role, ssn: "666667666" } }
    end

    assert_redirected_to employee_url(Employee.last)
  end
  
   test "should not create employee" do
    assert_difference('Employee.count') do
      post employees_url, params: { employee: { active: @ed.active, date_of_birth: @ed.date_of_birth, first_name: @ed.first_name, last_name: @ed.last_name, phone: @ed.phone, role: @ed.role, ssn: "666666666"} }
    end
  end


  test "should show employee" do
    get employee_url(@ed)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@ed)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@ed), params: { employee: { active: @ed.active, date_of_birth: @ed.date_of_birth, first_name: @ed.first_name, last_name: @ed.last_name, phone: @ed.phone, role: @ed.role, ssn: @ed.ssn } }
    assert_redirected_to employee_url(@ed)
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete employee_url(@ed)
    end

    assert_redirected_to employees_url
  end
  
  
end
