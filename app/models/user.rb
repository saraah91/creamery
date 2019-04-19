class User < ApplicationRecord
    has_secure_password
    #Relationships
    belongs_to :employee
    
    #Validations
    validates_format_of :email, with: /([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})/, message: "email should be in the right format", allow_blank: false
    validates_uniqueness_of :email
    
end
