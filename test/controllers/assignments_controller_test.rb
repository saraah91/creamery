require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  
    setup do
      create_contexts
      #@assignment = assignments(:one)
    end

    teardown do
      remove_contexts
    end

  test "should get index" do
    get assignments_url
    assert_response :success
  end
  
  test "should get current assignments" do
    get current_assignments_url
    assert_response :success
  end
  
  test "should get past assignments" do
    get past_assignments_url
    assert_response :success
  end
  
  test "should get assignments by store" do
    get by_store_assignments_url
    assert_response :success
  end
  
  test "should get assignments by employee" do
    get by_employee_assignments_url
    assert_response :success
  end
  
  test "should get assignments chronologically" do
    get chronological_assignments_url
    assert_response :success
  end

  test "should get new" do
    get new_assignment_url
    assert_response :success
  end

  test "should create assignment" do
    assert_difference('Assignment.count') do
      post assignments_url, params: { assignment: { employee_id: @assignment.employee_id, end_date: @assignment.end_date, pay_level: @assignment.pay_level, start_date: @assignment.start_date, store_id: @assignment.store_id } }
    end

    assert_redirected_to assignment_url(Assignment.last)
  end

  test "should show assignment" do
    get assignment_url(@assignment)
    assert_response :success
  end

  test "should get edit" do
    get edit_assignment_url(@assignment)
    assert_response :success
  end

  test "should update assignment" do
    patch assignment_url(@assignment), params: { assignment: { employee_id: @assignment.employee_id, end_date: @assignment.end_date, pay_level: @assignment.pay_level, start_date: @assignment.start_date, store_id: @assignment.store_id } }
    assert_redirected_to assignment_url(@assignment)
  end

  test "should destroy assignment" do
    assert_difference('Assignment.count', -1) do
      delete assignment_url(@assignment)
    end

    assert_redirected_to assignments_url
  end
end
