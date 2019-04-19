class Flavor < ApplicationRecord
    
    #Relationships
    has_many :store_flavors
    has_many :stores, through: :store_flavors
    
    #Validations
    validates_presence_of :name
    
    #Scopes
    scope :active,          -> { where(active: true) }
    scope :inactive,        -> { where(active: false) }
    scope :alphabetical,    -> { order('name') }

    
end
