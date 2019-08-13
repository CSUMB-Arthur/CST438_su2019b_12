class OrdersController < ApplicationController

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

      if @order.save
        render json: @order, status: 200
      else
        render json: @order.errors.messages, status: 400
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
      params.require(:order).permit(:itemId, :customerId, :description, :price, :award, :total)
    end
end
