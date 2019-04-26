require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  # Test relationships
   should belong_to(:employee)
   should belong_to(:store)

  # # Test basic validations
  # # for pay level
  should allow_value(1).for(:pay_level)
  should allow_value(2).for(:pay_level)
  should allow_value(3).for(:pay_level)
  should allow_value(4).for(:pay_level)
  should allow_value(5).for(:pay_level)
  should allow_value(6).for(:pay_level)
  should_not allow_value("bad").for(:pay_level)
  should_not allow_value(0).for(:pay_level)
  should_not allow_value(7).for(:pay_level)
  should_not allow_value(2.5).for(:pay_level)
  should_not allow_value(-2).for(:pay_level)
  # # for start date
  should allow_value(7.weeks.ago.to_date).for(:start_date)
  should allow_value(2.years.ago.to_date).for(:start_date)
  should_not allow_value(1.week.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(nil).for(:start_date)

  # # Need to do the rest with a context
  context "Creating a context for assignments" do
    setup do
      create_contexts
    end

    teardown do
    #  remove_contexts
    end

    should "have a scope 'for_store' that works" do
      assert_equal 4, Assignment.for_store(@cmu.id).size
      assert_equal 1, Assignment.for_store(@oakland.id).size
    end

    should "have a scope 'for_employee' that works" do
      assert_equal 2, Assignment.for_employee(@ben.id).size
      assert_equal 1, Assignment.for_employee(@kathryn.id).size
    end

    should "have a scope 'for_pay_level' that works" do
      assert_equal 2, Assignment.for_pay_level(1).size
      assert_equal 0, Assignment.for_pay_level(2).size
      assert_equal 2, Assignment.for_pay_level(3).size
      assert_equal 1, Assignment.for_pay_level(4).size
    end

    should "have a scope 'for_role' that works" do
      assert_equal 2, Assignment.for_role("employee").size
      assert_equal 3, Assignment.for_role("manager").size
    end

    should "have all the assignments listed alphabetically by store name" do
      assert_equal ["CMU", "CMU", "CMU", "CMU", "Oakland"], Assignment.by_store.map{|a| a.store.name}
    end

    should "have all the assignments listed chronologically by start date" do
      assert_equal ["Ben", "Kathryn", "Cindy", "Ben", "Alex"], Assignment.chronological.map{|a| a.employee.first_name}
    end

    should "have all the assignments listed alphabetically by employee name" do
      assert_equal ["Crawford", "Heimann", "Janeway", "Sisko", "Sisko"], Assignment.by_employee.map{|a| a.employee.last_name}
    end

    should "have a scope to find all current assignments for a store or employee" do
      assert_equal 3, Assignment.current.for_store(@cmu.id).size
      assert_equal 1, Assignment.current.for_store(@oakland.id).size
      assert_equal 1, Assignment.current.for_employee(@ben.id).size
      assert_equal 1, Assignment.current.for_employee(@ed.id).size
    end

    should "have a scope to find all past assignments for a store or employee" do
      assert_equal 1, Assignment.past.for_store(@cmu.id).size
      assert_equal 0, Assignment.past.for_store(@oakland.id).size
      assert_equal 1, Assignment.past.for_employee(@ben.id).size
      assert_equal 0, Assignment.past.for_employee(@cindy.id).size
    end

    should "allow for a end date in the past (or today) but after the start date" do
      # Note that we've been testing end_date: nil for a while now so safe to assume works...
      @assign_alex = FactoryBot.build(:assignment, employee: @alex, store: @oakland, start_date: 3.months.ago.to_date, end_date: 1.month.ago.to_date)
      assert @assign_alex.valid?
      @second_assignment_for_alex = FactoryBot.build(:assignment, employee: @alex, store: @oakland, start_date: 3.weeks.ago.to_date, end_date: Date.current)
      assert @second_assignment_for_alex.valid?
    end

    should "not allow for a end date in the future or before the start date" do
      # since Ed finished his last assignment a month ago, let's try to assign the lovable loser again ...
      @second_assignment_for_ed = FactoryBot.build(:assignment, employee: @ed, store: @oakland, start_date: 2.weeks.ago.to_date, end_date: 3.weeks.ago.to_date)
      assert_not_equal true,@second_assignment_for_ed.valid?
      @third_assignment_for_ed = FactoryBot.build(:assignment, employee: @ed, store: @oakland, start_date: 2.weeks.ago.to_date, end_date: 3.weeks.from_now.to_date)
      assert_equal false, @third_assignment_for_ed.valid?
      
    end

    should "identify a non-active store as part of an invalid assignment" do
      inactive_store = FactoryBot.build(:assignment, store: @hazelwood, employee: @ed, start_date: 1.day.ago.to_date, end_date: nil)
      assert_equal false,inactive_store.valid?
    end

    should "identify a non-active employee as part of an invalid assignment" do
      @fred = FactoryBot.build(:employee, first_name: "Fred", active: false)
      inactive_employee = FactoryBot.build(:assignment, store: @oakland, employee: @fred, start_date: 1.day.ago.to_date, end_date: nil)
      assert_equal false,inactive_employee.valid?
      @fred.destroy
    end

    should "have a scope currently_working? that works" do
      assert_equal true, @ed.currently_working?
    end
    
    should "end upcoming shifts associated with an assignments when it is terminated" do
      @shift0 = FactoryBot.create(:shift, assignment:@promote_ben, date: Date.tomorrow)
      @assignment0 = FactoryBot.create(:assignment, employee: @ben, store: @cmu, start_date: Date.current, end_date: nil, pay_level: 5)
      assert_equal false, Shift.exists?(@shift0.id)
      @shift0.destroy
      @assignment0.destroy 
    end

    should "make assignments that have worked shifts inactive" do
      @sara = FactoryBot.create(:employee, ssn:"909090909", first_name: "Cindy", last_name: "Crawford", date_of_birth: 17.years.ago.to_date)
      @sarahome = FactoryBot.create(:store, name: "Home", phone: "412-268-8291")
      @assign_sara = FactoryBot.create(:assignment, employee: @sara, store: @sarahome)
      @sara_shift = FactoryBot.create(:shift, assignment: @assign_sara)
      @sara_shift.update_attribute(:date, Date.current-5)
      puts "fgdfsdas"
      puts Assignment.past.for_employee(@sara.id)
      puts @sara_shift.date < Date.current
      @sara_shift.destroy
      assert @sara_shift.destroyed?
      assert_equal 0, Assignment.past.for_employee(@sara.id).size
      @sara.destroy
      @sarahome.destroy
      @sara_shift.destroy
      @assign_sara.destroy
      @sara_shift.destroy
    end  

    should "end upcoming shifts when assignment is terminated" do
      @shift = FactoryBot.create(:shift, assignment:@promote_ben, date: Date.tomorrow)
      @sara = FactoryBot.create(:employee, ssn:"909090909", first_name: "Cindy", last_name: "Crawford", date_of_birth: 17.years.ago.to_date)
      @sara_assignment = FactoryBot.create(:assignment, employee: @sara, store: @cmu, start_date: Date.current, end_date: nil, pay_level: 5)
      assert_equal true, Shift.exists?(@shift.id)
      @sara_assignment.destroy
      @shift.destroy 
    end
    
    should "end the current assignment if it exists before adding a new assignment for an employee" do
      @promote_kathryn = FactoryBot.create(:assignment, employee: @kathryn, store: @oakland, start_date: 1.day.ago.to_date, end_date: nil, pay_level: 4)
      assert_equal Date.current, @kathryn.assignments.first.end_date
      @promote_kathryn.destroy
    end


    
  end
end
