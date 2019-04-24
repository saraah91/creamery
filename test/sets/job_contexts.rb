module Contexts
  module JobContexts
    # Context for jobs
    def create_jobs
        @sweeping = FactoryBot.create(:job, name: "sweeping", description: "sweeping the floors", active: true)
        @cleaning_windows = FactoryBot.create(:job, name: "cleaning windows", description: "Cleaning the Windows", active: true)
        @dusting = FactoryBot.create(:job, name: "dusting", description: "sweeping the dust away", active: true)
        @manage = FactoryBot.create(:job, name: "managing", description: "managing employees", active: true)
        @mopping = FactoryBot.create(:job, name: "mopping", description: "mopping water from the floor", active: true)
        
        #Assigning a shift to an employee to check if the callback works
        @sara = FactoryBot.create(:employee, ssn:"909090909", first_name: "Cindy", last_name: "Crawford", date_of_birth: 17.years.ago.to_date)
        @sarahome = FactoryBot.create(:store, name: "home", phone: "412-268-8291")
        @assign_sara = FactoryBot.create(:assignment, employee: @sara, store: @sarahome)
        @saramorning = FactoryBot.create(:shift, assignment_id: @assign_sara.id, date: "2019-04-17", start_time: "05:39:00", end_time: "20:39:02", notes: "Morning Shift")
        @sara_shift = FactoryBot.create(:shift, assignment: @assign_sara, date: 18.day.from_now.to_date)
        @sara_shiftjob = FactoryBot.create(:shift_job, shift: @sara_shift, job: @sweeping)
    end
    
    def remove_jobs
        @sweeping.destroy
        @cleaning_windows.destroy
        @dusting.destroy
        @manage.destroy
        
        #extras
        @sara.destroy
        @sarahome.destroy
        @assign_sara.destroy
        @saramorning.destroy
        @sara_shift.destroy
        @sara_shiftjob .destroy

    end
    
    def create_additional_jobs
        @greet = FactoryBot.create(:job, name: "greet", description:"greet customers", active: false)
        @laundry = FactoryBot.create(:job, name: "laundry", description:"clean the bathrooms", active: false)
    end
    
    def remove_additional_jobs
        @greet.destroy
        @laundry.destroy
    end
    
  end
end