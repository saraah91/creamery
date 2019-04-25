# require needed files

require './test/sets/store_contexts'
require './test/sets/employee_contexts'
require './test/sets/assignment_contexts'
require './test/sets/job_contexts'
require './test/sets/flavor_contexts'
require './test/sets/shift_contexts'
require './test/sets/shift_job_contexts'
require './test/sets/store_contexts'
require './test/sets/store_flavor_contexts'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::StoreContexts
  include Contexts::EmployeeContexts
  include Contexts::AssignmentContexts
  include Contexts::JobContexts
  include Contexts::FlavorContexts
  include Contexts::ShiftJobContexts
  include Contexts::StoreFlavorContexts
  include Contexts::ShiftContexts

 def create_contexts
    create_employees
    create_stores
    create_assignments
    create_shifts
    create_jobs
    create_flavors
    create_shift_jobs
    create_store_flavors
 end
  
  def destroy_contexts
    remove_employees
    remove_stores
    remove_assignments
    remove_jobs
    remove_flavors
    destroy_shift_jobs
    remove_store_flavors
    destroy_shifts
  end
  
 def create_additional_contexts
    create_additional_employees
    create_additional_stores
    create_additional_assignments
    create_additional_jobs
    create_additional_flavors
    create_additional_shift_jobs
    create_additional_store_flavors
    create_additional_shifts
 end
  
  def destroy_additional_contexts
    remove_additional_employees
    remove_additional_stores
    remove_additional_assignments
    remove_additional_jobs
    remove_additional_flavors
    destroy_additional_shift_jobs
    remove_additional_store_flavors
    destroy_additional_shifts
  end
  
end