module Contexts
 module StoreFlavorContexts
    def create_store_flavors
      @chocolate_cmu      = FactoryBot.create(:store_flavor, flavor: @chocolate, store: @cmu)
      @chocolate_oakland  = FactoryBot.create(:store_flavor, flavor: @chocolate, store: @oakland)
      @vanilla_hazelwood= FactoryBot.create(:store_flavor, flavor: @vanilla, store: @hazelwood)
      @vanilla_cmu = FactoryBot.create(:store_flavor, flavor: @vanilla, store: @cmu)
      @pistachio_oakland      = FactoryBot.create(:store_flavor, flavor: @pistachio, store: @oakland)
    end
    
    def remove_store_flavors
      @chocolate_cmu.destroy
      @chocolate_oakland.destroy
      @vanilla_hazelwood.destroy
      @vanilla_cmu.destroy
      @pistachi_ooakland.destroy
    end
        
    def create_additional_store_flavors
      @cookie_dough_cmu      = FactoryBot.create(:store_flavor, flavor: @cookie_dough, store: @cmu)
      @cookie_dough_oakland  = FactoryBot.create(:store_flavor, flavor: @cookie_dough, store: @oakland)
      @cotton_candy_hazelwood= FactoryBot.create(:store_flavor, flavor: @cotton_candy, store: @hazelwood)
      @cotton_candy_cmu = FactoryBot.create(:store_flavor, flavor: @cotton_candy, store: @cmu)
      @cotton_candy_oakland      = FactoryBot.create(:store_flavor, flavor: @cotton_candy, store: @oakland)
    end
    
    def remove_additional_store_flavors
      @cookie_dough_cmu.destroy
      @cookie_dough_oakland.destroy
      @cotton_candy_hazelwood.destroy
      @cotton_candy_cmu.destroy
      @cotton_candy_oakland.destroy
    end
        
 end 
end
    