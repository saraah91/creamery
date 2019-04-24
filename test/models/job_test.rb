require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # Test relationships
  should have_many(:shift_jobs)
  #should have_many(:shifts).through(:jobs)
  
  # Test valifations
  should validate_presence_of(:name)
  
  context "Creating a context for jobs" do
    # create the objects I want with factories
    setup do 
      create_contexts
      create_additional_contexts
    end
    
    # and provide a teardown method as well
    teardown do
      #remove_contexts
      #remove_additional_contexts
    end

    # test the scope 'active'
    should "shows that there are four active jobs" do
      assert_equal 5, Job.active.size
      assert_equal ["cleaning windows", "dusting", "managing", "mopping", "sweeping"], Job.active.map{|e| e.name}.sort
    end
    
    # test the scope 'inactive'
    should "shows that there are two inactive jobs" do
      assert_equal 2, Job.inactive.size
      assert_equal ["greet", "laundry"], Job.inactive.map{|e| e.name}.sort
    end
    
    should "allow deleting jobs that hasn't been worked by an employee" do
      assert_equal 5, Job.active.size
      @mopping.destroy
      assert_equal 4, Job.active.size
    end
    
    should "not allow deleting jobs that has been worked by an employee" do
        #Assigning a shift to an employee to check if the callback works
      @sara = FactoryBot.create(:employee, ssn:"909090909", first_name: "Cindy", last_name: "Crawford", date_of_birth: 17.years.ago.to_date)
      @sarahome = FactoryBot.create(:store, name: "Home", phone: "412-268-8291")
      @assign_sara = FactoryBot.create(:assignment, employee: @sara, store: @sarahome)
      @saramorning = FactoryBot.create(:shift, assignment_id: @assign_sara.id, date: "2019-04-17", start_time: "05:39:00", end_time: "20:39:02", notes: "Morning Shift")
      @sara_shift = FactoryBot.create(:shift, assignment: @assign_sara, date: 18.day.from_now.to_date)
      @sara_shiftjob = FactoryBot.create(:shift_job, shift: @sara_shift, job: @sweeping)

      assert_equal 5, Job.active.size
      @sweeping.destroy
      assert_equal 4, Job.active.size
      assert_equal 3, Job.inactive.size
      assert_equal ["greet", "laundry", "sweeping"], Job.inactive.map{|e| e.name}.sort
      
      @sara.destroy
      @sarahome.destroy
      @assign_sara.destroy
      @saramorning.destroy
      @sara_shift.destroy
      @sara_shiftjob.destroy

    end
  end
end
