require 'test_helper'

class ShiftJobTest < ActiveSupport::TestCase
  should belong_to(:shift)
  should belong_to(:job)

end
