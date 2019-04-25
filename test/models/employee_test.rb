require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # Test relationships
  should have_many(:assignments)
  should have_many(:stores).through(:assignments)
  
  # Test basic validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:ssn)
  should validate_presence_of(:role)
  should validate_presence_of(:date_of_birth)
  # tests for phone
 
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  should allow_value(nil).for(:phone)
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("14122683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  # tests for ssn
  should_not allow_value("bad").for(:ssn)
  should_not allow_value(nil).for(:ssn)
   # test date_of_birth
  should allow_value(17.years.ago.to_date).for(:date_of_birth)
  should allow_value(15.years.ago.to_date).for(:date_of_birth)
  should allow_value(14.years.ago.to_date).for(:date_of_birth)
  should_not allow_value(13.years.ago).for(:date_of_birth)
  should_not allow_value("bad").for(:date_of_birth)
  should_not allow_value(nil).for(:date_of_birth)
   # tests for role
  should allow_value("admin").for(:role)
  should allow_value("manager").for(:role)
  should allow_value("employee").for(:role)
  should_not allow_value("bad").for(:role)
  should_not allow_value("hacker").for(:role)
  should_not allow_value(10).for(:role)
  should_not allow_value("vp").for(:role)
  should_not allow_value(nil).for(:role)

  context "Creating a context for employees" do
    # create the objects I want with factories
    setup do 
      #  create_contexts
      create_employees
    end
    
    # and provide a teardown method as well
    teardown do
    #  remove_employees
    end
  
    # now run the tests:
    # test employees must have unique ssn
    should "force employees to have unique ssn" do
      repeat_ssn = FactoryBot.build(:employee, first_name: "Steve", last_name: "Crawford", ssn: "231100856")
      #deny repeat_ssn.valid?
      assert_equal false , repeat_ssn.valid? 
    end
    
    # test scope younger_than_18
    should "show there are two employees under 18" do
      assert_equal 2, Employee.younger_than_18.size
      assert_equal ["Crawford", "Wilson"], Employee.younger_than_18.map{|e| e.last_name}.sort
    end
    
    # test scope younger_than_18
    should "show there are four employees over 18" do
      assert_equal 4, Employee.is_18_or_older.size
      puts Employee.is_18_or_older.map{|e| e.first_name}.sort
      assert_equal ["Heimann", "Heimann", "Janeway", "Sisko"], Employee.is_18_or_older.map{|e| e.last_name}.sort
    end
    
    # test the scope 'active'
    should "shows that there are five active employees" do
      puts Employee.active.map{|e| e.last_name}.sort
      assert_equal 5, Employee.active.size
      assert_equal ["Crawford", "Heimann", "Heimann", "Janeway", "Sisko"], Employee.active.map{|e| e.last_name}.sort
    end
    
    # test the scope 'inactive'
    should "shows that there is one inactive employee" do
      assert_equal 1, Employee.inactive.size
      assert_equal ["Wilson"], Employee.inactive.map{|e| e.last_name}.sort
    end
    
    # test the scope 'regulars'
    should "shows that there are 3 regular employees: Ed, Cindy and Ralph" do
      remove_employees
      puts Employee.regulars.map{|e| e.first_name}.sort

      assert_equal 3, Employee.regulars.size
      assert_equal ["Crawford","Heimann","Wilson"], Employee.regulars.map{|e| e.last_name}.sort
    end
    
    # test the scope 'managers'
    should "shows that there are 2 managers: Ben and Kathryn" do
      assert_equal 2, Employee.managers.size
      assert_equal ["Janeway", "Sisko"], Employee.managers.map{|e| e.last_name}.sort
    end
    
    # test the scope 'admins'
    should "shows that there is one admin: Alex" do
      assert_equal 1, Employee.admins.size
      assert_equal ["Heimann"], Employee.admins.map{|e| e.last_name}.sort
    end
    
    # test the method 'name'
    should "shows name as last, first name" do
      assert_equal "Heimann, Alex", @alex.name
    end   
    
    # test the method 'proper_name'
    should "shows proper name as first and last name" do
      assert_equal "Alex Heimann", @alex.proper_name
    end 
    
    # test the method 'current_assignment'
    should "return employee's current assignment if it exists" do
      @cmu = FactoryBot.create(:store)
      @assign_ed = FactoryBot.create(:assignment, employee: @ed, store: @cmu, start_date: 1.year.ago.to_date, end_date: 1.month.ago.to_date) 
      @cindy = FactoryBot.create(:employee, first_name: "Cindy", last_name: "Crawford", ssn: "231167896", date_of_birth: 17.years.ago.to_date)
      @assign_cindy = FactoryBot.create(:assignment, employee: @cindy, store: @cmu, start_date: 14.months.ago.to_date, end_date: nil)
      @alex = FactoryBot.create(:employee, first_name: "Alex", last_name: "Heimann", ssn: "203997856", role: "admin")
      # person with a current assignment
      assert_equal @assign_cindy, @cindy.current_assignment # only 1 assignment ever
      assert_equal @promote_ben, @ben.current_assignment # 2 assignments, returns right one
      # person had assignments but has no current assignment
      assert_nil @ed.current_assignment
      @assign_cindy.update_attribute(:end_date, Date.current)
      @cindy.reload
      assert_nil @cindy.current_assignment
      # person with no assignments ever has no current assignment
      assert_nil @alex.current_assignment
      @cmu.destroy
      @assign_ed.destroy
      @cindy.destroy
      @assign_cindy.destroy
      @alex.destroy
    end
    
    # test the callback is working 'reformat_ssn'
    should "shows that Cindy's ssn is stripped of non-digits" do
      assert_equal "231100856", @cindy.ssn
    end
    
    # test the callback is working 'reformat_phone'
    should "shows that Ben's phone is stripped of non-digits" do
      assert_equal "4122682323", @ben.phone
    end
    
    # test the method 'over_18?'
    should "shows that over_18? boolean method works" do
      assert @ed.over_18?
      assert_not_equal @cindy.over_18?, true
    end
    
    # test the method 'age'
    should "shows that age method returns the correct value" do
      assert_equal 26, @ed.age
      assert_equal 17, @cindy.age
      assert_equal 30, @kathryn.age
    end
    
    # should "check whether never_worked_shift? works" do
    #   @sara = FactoryBot.create(:employee, ssn:"909090909", first_name: "Cindy", last_name: "Crawford", date_of_birth: 17.years.ago.to_date)
    #   puts @sara.never_worked_shift?
    #   assert true, @sara.never_worked_shift?
    # end
    
    should "delete employees that has never worked a shift" do
      @saramoh = FactoryBot.create(:employee, first_name: "Sara", last_name: "Almoh", ssn: "278997856", role: "admin")
      assert_equal 2, Employee.admins.size
      assert_equal ["Almoh","Heimann"], Employee.admins.map{|e| e.last_name}.sort
      @saramoh.destroy
      assert_equal 1, Employee.admins.size
      assert_equal ["Heimann"], Employee.admins.map{|e| e.last_name}.sort

      
    end
    
  end
end
