class User < ApplicationRecord
    
    #Relationships
    belongs_to :employee
    
    #Validations
    validates_format_of :email, :with => ['/^\d{0-9}[@]d{0-9}$/'], :message => "email must be in the right";
    validates_uniqueness_of :email
    
    
end
