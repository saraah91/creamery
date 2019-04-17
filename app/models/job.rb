class Job < ApplicationRecord
    
    #Relationships
    has_many :shift_jobs
	has_many :shifts, through: :shift_jobs
end
