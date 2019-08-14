require 'httparty'   
require 'json'

class Order < ApplicationRecord
    include HTTParty
    format :json
    after_create :update_items_and_customers
    
    def update_items_and_customers
      failure = false
      self.class.base_uri "http://localhost:8081"
      uri = "/customers/order"

      response = self.class.put uri,
        body: {order:{price: self.price, customerId: self.customerId, award: self.award}}.to_json,
        headers: { 'Content-Type' => 'application/json',
        'ACCEPT' => 'application/json' }
        puts response.code
        if response.code != 204
            logger.debug "customer order failed"
          failure = true
        end
    
      self.class.base_uri "http://localhost:8082"
      uri = "/items/order"
      #order:{itemId: 1, description: "idk", customerId: 1, price: 19.95, award: 1.00, total: 18.95}
      response = self.class.put uri,
        body: {order:{itemId: self.itemId}}.to_json,
        headers: { 'Content-Type' => 'application/json',
        'ACCEPT' => 'application/json' }
    
        if response.code != 204
            logger.debug "item order failed"
          failure = true
        end
        
        if failure
            #sadly won't rollback item or customer changes, in the case one fails and one passes
            #but better than nothing
            raise ActiveRecord::Rollback, "Rolling back changes"
        end
    
    end
    
end
