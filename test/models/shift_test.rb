require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  
  should have_many(:shift_jobs)
  should have_many(:jobs).through(:shift_jobs)
  should have_one(:store).through(:assignment)
  should have_one(:employee).through(:assignment)

  should validate_presence_of(:date)
  should validate_presence_of(:start_time)
  should validate_presence_of(:assignment_id)
  should validate_presence_of(:assignment_id).on(:update)
  
  
  context "Creating a context for assignments" do
    setup do
      create_contexts
      # @ben = FactoryBot.create(:employee, first_name: "Ben", last_name: "Sisko", role: "manager", phone: "412-268-2323", active: true)
      # @assign_ben = FactoryBot.create(:assignment, employee: @ben, store: @cmu, start_date: 2.years.ago.to_date, end_date: 6.months.ago.to_date, pay_level: 3)
 
      # @morning = FactoryBot.create(:shift, assignment_id: 1, date: "2019-04-17", start_time: "", end_time: "20:39:02", notes: "Morning Shift")
      # @noon = FactoryBot.create(:shift, assignment_id: 1, date: "2019-04-19", start_time: "18:39:00", end_time: "20:39:02", notes: "Noon Shift")
      # @night = FactoryBot.create(:shift, assignment_id: 1, date: "2019-04-19", start_time: "19:39:00", end_time: "20:39:02", notes: "Night Shift")
    end

    teardown do
    end
    
    should "if completed? function work" do
      @shift = FactoryBot.create(:shift, date: Date.today-5)
      assert !@shift.completed?
      @shift.destroy
    end
    
    should "check if end_time automatically set after 3 hours" do
      @shift = FactoryBot.create(:shift, start_time: "18:00:00")
      assert @shift.end_time == "21:00:00"
      @shift.destroy
    end
    
    should "check if start_now works" do
      @shift = FactoryBot.create(:shift)
    #  puts Time.now
    #  puts @shift.start_time
      @shift.start_now
      assert @shift.start_time.to_i == Time.now.to_i
      @shift.destroy
    end
    
     should "check if end_now works" do
      @shift = FactoryBot.create(:shift)
    #  puts Time.now
    #  puts @shift.start_time
      @shift.end_now
      assert @shift.end_time.to_i == Time.now.to_i
      @shift.destroy
     end
    
    # should "force assignments to be in the future" do
    #   @assign_s = FactoryBot.create(:assignment, employee: @kathryn, store: @oakland, end_date: Date.today-5, pay_level: 3)
    #   shift = FactoryBot.build(:shift, assignment_id: 6)
    # #  puts shift.assignment 
    # # puts shift.assignment.end_date == nil
    #   assert_equal false , shift.valid? 
    # end
    

    should "have a scope for_employee that works" do
      assert_equal [1,4,5], Shift.for_employee(1).map{|i| i.id}.sort
    end


    should "have a scope upcoming that works" do
      assert_equal [4, 5], Shift.upcoming.map{|i| i.id}.sort
    end


    should "have a scope for_past_days that works" do
      @shift = FactoryBot.create(:shift, date: Date.current-5)
      assert_equal [6], Shift.for_past_days(6).map{|i| i.id}.sort
      @shift.destroy
    end

    should "have a scope by_store that works" do
      assert_equal [1, 2, 3, 4, 5], Shift.by_store.map{|i| i.id}
    end

    should "have a scope by_employee that works" do
      assert_equal [1, 4, 5, 2, 3], Shift.by_employee.map{|i| i.id}
    end

    
  end


end
