require 'httparty'   
require 'json'

class OrdersController < ApplicationController
  include HTTParty
  format :json
  
  # POST /orders
  # POST /orders.json
  def create
    fail = false
    itemId = order_params[:itemId]
    customerId = order_params[:customerId]
    
    #logger.debug "getting item"
    self.class.base_uri "http://localhost:8082"
    uri = "/items/%d" % [itemId]
    response = self.class.get uri
    
    #Check if item of this id was fetched correctly
    if response.code == 200
      item = response.body
    else
      fail = true
    end
    #logger.debug item

    #logger.debug "getting customer"
    self.class.base_uri "http://localhost:8081"
    uri = "/customers?id=%d" % [customerId]
    response = self.class.get uri
    

    #Check if customer of this id was fetched correctly
    if response.code == 200
      customer = response.body
    else
      fail = true
    end
    #logger.debug customer
        
    #If item and customer are found, create the order, otherwise, give a 404 not found error
    if !fail
      #logger.debug "success"
      item = JSON.parse(item)
      description = item["description"]
      
      price = item["price"].to_f #to float, as it's parsed as a string for some reason
      logger.debug price
      customer = JSON.parse(customer)
      
      #maybe modify customer server to retrieve customer award calculations, instead of recalculating using a formula that might not sync with the other server
      award = (0.10 * (customer["lastOrder"] + customer["lastOrder2"] + customer["lastOrder3"])/3)
      total = price - award
  
      @order = Order.new({itemId: itemId, customerId: customerId, description: description, price: price, award: award, total: total})
      if @order.save
        render json: @order, status: 201
        
      #  #raise ActiveRecord::Rollback, "Rolling back changes"
      else
        render json: @order.errors.messages, status: 400
      end
    else
      head 404
    end

  end

  # GET "orders/:id"
  def retrieveById
    #find throws an error instead of returning nil
    @order = Order.find(params[:id]) rescue nil

    #success
    if @item
      render json: @order , status: 200
    #failure
    else
      render json: "", status: 404
    end
  end

  def retrieveByOther
    
    #customer id to search for, if given, otherwise determine the id from email.
    targetId = params[:customerId]
    if targetId == nil
      @customer = Customer.find_by(email: params[:email])
      targetId = @customer[:id]
    end

    @orders = Order.find_by(customerId: targetId)
    
   if @orders
     #success
     render json: @orders , status: 200
   else
     #failure 
     head 404
   end
     
  end


  private


    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:itemId, :customerId)
    end
end
