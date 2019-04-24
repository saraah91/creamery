module Contexts
  module JobContexts
    # Context for jobs
    def create_jobs
        @sweeping = FactoryBot.create(:job, name: "sweeping", description: "sweeping the floors", active: true)
        @cleaning_windows = FactoryBot.create(:job, name: "cleaning windows", description: "Cleaning the Windows", active: true)
        @dusting = FactoryBot.create(:job, name: "dusting", description: "sweeping the dust away", active: true)
        @manage = FactoryBot.create(:job, name: "managing", description: "managing employees", active: true)
        @mopping = FactoryBot.create(:job, name: "mopping", description: "mopping water from the floor", active: true)
        end
    
    def remove_jobs
        @sweeping.destroy
        @cleaning_windows.destroy
        @dusting.destroy
        @manage.destroy
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