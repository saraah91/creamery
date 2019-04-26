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
      @morning = @morning.start_now
      assert @morning.start_time == Time.now
      @morning.destroy
    end
    
    # should "check if end_now works" do
    #   @night = @night.end_now
    #   assert @night.end_time == Time.now
    #   @night.destroy
    # end
    
    
    
  end


end
