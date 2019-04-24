require 'test_helper'

class FlavorTest < ActiveSupport::TestCase
  # Test relationships
  should have_many(:store_flavors)
  #should have_many(:shifts).through(:jobs)
  
  # Test valifations
  should validate_presence_of(:name)
  
  context "Creating a context for flavors" do
    # create the objects I want with factories
    setup do 
      create_contexts
      create_additional_contexts
    end
    
    # and provide a teardown method as well
    teardown do
      # destroy_contexts
      # destroy_additional_contexts    
    end

    # test the scope 'active'
    should "shows that there are eight active flavors" do
      assert_equal 8, Flavor.active.size
      assert_equal ["black_tea", "chocolate", "coffee", "cookie dough", "garlic", "grape", "green_tea", "vanilla"], Flavor.active.map{|e| e.name}.sort
    end
    
    # test the scope 'inactive'
    should "shows that there are two inactive flavors" do
      assert_equal 2, Flavor.inactive.size
      assert_equal ["cotton candy", "pistachio"], Flavor.inactive.map{|e| e.name}.sort
    end
    should "Show that flavors are never deleted, only made inactive" do
      @vanilla.destroy
      @chocolate.destroy
      assert_equal 6, Flavor.active.size
      assert_equal ["black_tea", "coffee", "cookie dough", "garlic", "grape", "green_tea"], Flavor.active.map{|e| e.name}.sort
    #  puts Flavor.alphabetical.map{|e| e.name}.sort
      assert_equal ["chocolate", "cotton candy", "pistachio", "vanilla"], Flavor.inactive.map{|e| e.name}.sort
    end

  end
end
