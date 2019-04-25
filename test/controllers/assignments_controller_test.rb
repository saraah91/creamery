require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
    
  @ben = FactoryBot.create(:employee, first_name: "Ben", last_name: "Sisko", ssn: "233567888",role: "manager", phone: "412-268-2323", active: true)
  @cmu = FactoryBot.create(:store)
  @assign_ed = FactoryBot.create(:assignment, employee: @ed, store: @cmu) # ended a month ago

  
  test "should get index" do
    assert assignments_url
    assert_response :success
  end

  test "should get new" do
    assert new_assignment_url
    assert_response :success
  end

  test "should create assignment" do
    assert_difference('Assignment.count') do
      post assignments_url, params: { assignment: { employee_id: 1, end_date: @assign_ben.end_date, pay_level: @assign_ben.pay_level, start_date: @assign_ben.start_date, store_id: 1 } }
    end

    assert_redirected_to assignment_url(Assignment.last)
  end

  test "should show assignment" do
    assert assignment_url(@assign_ben)
    assert_response :success
  end

  test "should show current assignments" do
    assert '/assignments/current'
    assert_response :success
  end
  
  test "should show past assignments" do
    assert '/assignments/past'
    assert_response :success
  end
 
  test "should show assignments by store" do
    assert '/assignments/by_store'
    assert_response :success
  end 

  test "should show assignments by employee" do
    assert '/assignments/by_employee'
    assert_response :success
  end 
  
  test "should show assignments chronologically" do
    assert '/assignments/chronological'
    assert_response :success
  end 
  
  test "should show assignments for store 1" do
    assert '/assignments/for_store'
    assert_response :success
  end 

  test "should show assignments for employee 1" do
    assert '/assignments/for_employee'
    assert_response :success
  end 
  
  test "should show assignments for pay level 1" do
    assert '/assignments/for_pay_level'
    assert_response :success
  end 
  
  test "should show assignments for done by employees" do
    assert '/assignments/for_pay_level'
    assert_response :success
  end 
  
  test "should get edit" do
    get edit_assignment_url(@assign_ben)
    assert_response :success
  end

  test "should update assignment" do
    patch assignment_url(@assign_ben), params: { assignment: { employee_id: @assign_ben.employee_id, end_date: @assign_ben.end_date, pay_level: @assign_ben.pay_level, start_date: @assign_ben.start_date, store_id: @assign_ben.store_id } }
    assert_redirected_to assignment_url(@assign_ben)
  end

  test "should destroy assignment" do
    assert_difference('Assignment.count', -1) do
      delete assignment_url(@assign_ben)
    end

    assert_redirected_to assignments_url
  end
    

end
