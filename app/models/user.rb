class User < ApplicationRecord
    has_secure_password
    #Relationships
    belongs_to :employee
    
    #Validations
    validates_format_of :email, with: /([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})/, message: "email should be in the right format", allow_blank: false
    validates_uniqueness_of :email
    validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: false
    
    def role
        self.employee.role
    end
    
    
end
