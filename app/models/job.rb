class Job < ApplicationRecord
    
    #Resources: 
    #https://guides.rubyonrails.org/active_record_callbacks.html
    #https://stackoverflow.com/questions/19044725/before-destroy-callback-not-stopping-record-from-being-deleted
    #https://github.com/rails/rails/issues/7640
    
    before_destroy :worked_by_an_employee
    after_rollback :set_as_inactive_if_ok
    
    #Relationships
    has_many :shift_jobs
	has_many :shifts, through: :shift_jobs
	
	#Validations
	validates_presence_of :name
	
	#Scopes
    scope :active,          -> { where(active: true) }
    scope :inactive,        -> { where(active: false) }
    scope :alphabetical,    -> { order('name') }
    
    
    private
    
    def worked_by_an_employee
        @destroy_attempt = self.shift_jobs.empty?
        """if self.shift_jobs.empty?
            @destroy_attempted = true
        else
            @destroy_attempted = false
        end"""
    end
  
    def make_inactive
        self.update_attribute(:active, false)
    end
    
    def set_as_inactive_if_ok
        make_inactive if @destroy_attempt == fasle
    end

end
