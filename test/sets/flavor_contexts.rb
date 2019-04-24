module Contexts
  module FlavorContexts
    # Context for flavors 
    def create_flavors
        @vanilla = FactoryBot.create(:flavor, name: "vanilla", active: true)
        @chocolate = FactoryBot.create(:flavor, name: "chocolate", active: true)
        @cookie_dough = FactoryBot.create(:flavor, name: "cookie dough", active: true)
        @pistachio = FactoryBot.create(:flavor, name: "pistachio", active: false)
        @cotton_candy  = FactoryBot.create(:flavor, name: "cotton candy", active: false)
    end
    
    def remove_flavors
        @vanilla.destroy
        @chocolate.destroy
        @cookie_dough.destroy
        @pistachio.destroy
        @cotton_candy.destroy
    end
    
    def create_additional_flavors
        @grape = FactoryBot.create(:flavor, name: "grape", active: true)
        @garlic = FactoryBot.create(:flavor, name: "garlic", active: true)
        @green_tea = FactoryBot.create(:flavor, name: "green_tea", active: true)
        @black_tea = FactoryBot.create(:flavor, name: "black_tea", active: true)
        @coffee = FactoryBot.create(:flavor, name: "coffee", active: true)
    end
    
    
    def remove_additional_flavors
        @grape.destroy
        @garlic.destroy
        @green_tea.destroy
        @green_tea.destroy
        @coffee.destroy
    end
  end
end
