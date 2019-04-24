class Flavor < ApplicationRecord
    
    #Callbacks
    before_destroy :dont
    after_rollback :make_inactive

    
    #Relationships
    has_many :store_flavors
    has_many :stores, through: :store_flavors
    
    #Validations
    validates_presence_of :name
    
    #Scopes
    scope :active,          -> { where(active: true) }
    scope :inactive,        -> { where(active: false) }
    scope :alphabetical,    -> { order('name') }
    
    private
    def dont
        throw :abort
    end
    def make_inactive
        self.update_attribute(:active, false)
    end

    
end
