class ShiftJob < ApplicationRecord
    
    #Relationships
    belongs_to :shift
    belongs_to :job
    
end
