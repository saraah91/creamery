require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to(:employee)
  
  should allow_value("sara@hotmail.com").for(:email)
  should_not allow_value("sara").for(:email)
  should_not allow_value(nil).for(:email)
  should allow_value("1234").for(:password)
  should allow_value("abcd").for(:password)
  should_not allow_value("1").for(:password)
  should_not allow_value(nil).for(:password)

  should validate_uniqueness_of (:email)
  
  
end
