require 'httparty'                            
require 'json'

class OrderClient

  include HTTParty


  base_uri 'http://localhost:8080'
  format :json
  
=begin
  #◦ create a new order
  ◦ retrieve an existing order by orderId, customerId, or customer email
  #◦ register a new customer
  ◦ lookup a customer by id or by email
  #◦ create a new item
  ◦ lookup an item by item id
=end

  def OrderClient.addOrder(itemId, customerId)
    
  end
  
  def OrderClient.addCustomer(lastName, firstName, email)
    
  end

  def OrderClient.addItem(description, price, stock)
    
  end
  
  def OrderClient.findCustomerByEmail(email)
    
  end
  
  def OrderClient.findItemById(id)
    
  end
  
  def OrderClient.findOrderById(id)
    
  end
  
  def OrderClient.findOrderByEmail(email)
    
  end
  
  def OrderClient.findOrderByCustomerId(customerId)
    
  end
  
end




exit = false
while exit == false do
  puts "Select an option: addorder, additem, addcustomer, getorder, getitem, getcustomer, quit"
  option = gets.chomp
  
  case option
    when "addorder"
      
      #puts "Input item description"
      #desc = gets.chomp
      #puts "Input item price"
      #price = gets.chomp
      #puts "Input item stock quantity"
      #qty = gets.chomp
      #puts "Attempting to create new entry..."
      #OrderClient.addEntry(desc, price, qty)

      
    when "additem"

      
    when "addcustomer"
      
    when "getorder" 
      invalid = true
      puts "Retrieve by: orderId, email, customerId, or quit"
      option2 = gets.chomp
      while invalid
        case option2
          when "orderId"
            #todo: search for order by id
          when "email"
            #todo: search for orders by email
          when "customerId"
            #todo: search for orders by customerid
          else
            puts "Unrecognized option"
        end
      end
    
    when "getcustomer" 
      valid = false
      puts "Retrieve by: email, customerId, or quit"
      option2 = gets.chomp
      while valid == false
        case option2
          when "email"
            #todo: search for customer by email
            valid = true
          when "customerId"
            #todo: search for customer by id
            valid = true
          else
            
            puts "Unrecognized option"
        end
      end
      
    when "quit"
      puts "Goodbye"
      exit = true
    else
      puts "Command not recognized"
  end
end