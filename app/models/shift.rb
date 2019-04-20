class Shift < ApplicationRecord
    
    # Callbacks
    before_create :end_after_three_hours
    
    #Relationships
    has_many :shift_jobs
	has_many :jobs, through: :shift_jobs
	belongs_to :assignment
	has_one :store, through: :assignment
	has_one :employee, through: :assignment
	
	#Validations
    validates_date :start_time, on_or_after: lambda { Time.current }, on_or_before_message: "cannot be in the past"
    validates_date :end_time, after: :start_time, on_or_before: lambda { Time.current }, allow_blank: true
    validates_presence_of :date, :start_time, :assignment_id
    validates_presence_of :assignment_id, on: :update

    #Scopes
    scope :for_store,     ->(store_id) { where("store_id = ?", store_id) }
    scope :for_employee,  ->(employee_id) { where("employee_id = ?", employee_id) }
    scope :completed,     -> { self.shift.completed }
    scope :incomplete,    -> { (self.shift.completed = false) }
    scope :past,          ->{ where('date < ?', Date.today) } 
    scope :upcoming,      ->{ where('date >= ?', Date.today)  }
    scope :for_next_days, ->(x) { where("date between ? and ?", Date.today, x.days.from_now.to_date) } #pls see
    scope :for_past_days, ->(x) { where("date between ? and ?", x.days.ago.to_date, 1.day.ago.to_date) } #pls see
    
    def completed?
        if self.shift_jobs > 0
            true
        else
            false
        end
    end    
	
	def end_after_three_hours
	    self.end_time = 3.hours.from_self.start_time 
	end
	
	def start_now
	    self.start_time = Time.now # do I have to do something update or is this fine
	end
	
	def end_now
	    self.end_time = Time.now # do I have to do something update or is this fine
	end
	
	# can only be deleted if the shift is scheduled for today or in the future
    validate :current_assignment, on: :create
    validate :current_assignment, on: :destroy
    
    def current_assignment
        unless self.assignment.start_date >= Date.today?
            errors.add(:assignment_id, "assignment is not current at the creamery")
        end
    end
    
    
end
