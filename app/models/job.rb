class Job < ApplicationRecord
    
    #Relationships
    has_many :shift_jobs
	has_many :shifts, through: :shift_jobs
	
	#Validations
	validates_presence_of :name
	
	#Scopes
    scope :active,          -> { where(active: true) }
    scope :inactive,        -> { where(active: false) }
    scope :alphabetical,    -> { order('last_name, first_name') }



	
end
