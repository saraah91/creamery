require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require 'rails/test_help'


require 'contexts'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all
  # Add more helper methods to be used by all tests here...
  include Contexts
  # Add more helper methods to be used by all tests here...
end
