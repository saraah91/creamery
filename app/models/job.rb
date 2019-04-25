class Job < ApplicationRecord
    
    #Resources: 
    #https://guides.rubyonrails.org/active_record_callbacks.html
    #https://stackoverflow.com/questions/19044725/before-destroy-callback-not-stopping-record-from-being-deleted
    #https://github.com/rails/rails/issues/7640
    
    #Relationships
    has_many :shift_jobs
	has_many :shifts, through: :shift_jobs
	
	#Validations
	validates_presence_of :name
	
	#Scopes
    scope :active,          -> { where(active: true) }
    scope :inactive,        -> { where(active: false) }
    scope :alphabetical,    -> { order('name') }
    
    before_destroy :can_delete?
    after_rollback :set_as_inactive_if_ok
    
    private
    
    def worked_by_an_employee?
        self.shift_jobs.empty?
    end
    
    def can_delete?
        throw :abort if not worked_by_an_employee?
    end
  
    def set_as_inactive_if_ok
        self.update_attribute(:active, false)
    end

end
