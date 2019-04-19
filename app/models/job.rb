class Job < ApplicationRecord
    
    before_destroy :allow_destroy
    after_rollback :make_inactive
    
    #Relationships
    has_many :shift_jobs
	has_many :shifts, through: :shift_jobs
	
	#Scopes
    scope :active,          -> { where(active: true) }
    scope :inactive,        -> { where(active: false) }
    scope :alphabetical,    -> { order('name') }
    
    # should I make those private?
    def allow_destroy
        self.shift_jobs.empty?
    end
  
    def make_inactive
        #if allow_destroy is true make inactive
    end

end
