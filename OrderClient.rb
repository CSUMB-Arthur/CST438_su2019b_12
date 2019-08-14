require 'httparty'                            
require 'json'

class OrderClient

  include HTTParty


  
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
    base_uri 'http://localhost:8080'
  end
  
  def OrderClient.addCustomer(lastName, firstName, email)
    base_uri 'http://localhost:8081'
    response = post '/customers',
        body: {customer:{lastName:  lastName, firstName:  firstName, email:  email}}.to_json,
        headers: {'Content-Type' => 'application/json',
        'ACCEPT' => 'application/json' }
        
        puts response.code
        if response.code == 201
          puts response.body
        end
  end

  def OrderClient.addItem(description, price, stock)
    base_uri 'http://localhost:8082'
      response = post '/items',
        body: {item:{description:  description, price:  price, stockQty:  stock}}.to_json,
        headers: { 'Content-Type' => 'application/json',
        'ACCEPT' => 'application/json' }
    
        puts response.code
        puts response.body
  end
  
  def OrderClient.findCustomerByEmail(email)
    base_uri 'http://localhost:8081'
      uri = "/customers?email=%s" % [email]
      response = get uri
        
        puts response.code
        if response.code == 200
          puts response.body
        end
  end
  
  def OrderClient.findCustomerById(id)
    base_uri 'http://localhost:8081'
    uri = "/customers?id=%s" % [id]
    response = get uri
      
      puts response.code
      if response.code == 200
        puts response.body
      end
  end
  
  def OrderClient.findItemById(id)
    base_uri 'http://localhost:8082'
    
      uri = "/items/%d" % [id]
      response = get uri
        
        puts response.code
        if response.code == 200
          puts response.body
        end
  end
  
  def OrderClient.findOrderById(id)
    base_uri 'http://localhost:8080'
    
      uri = "/orders/%d" % [id]
      response = get uri
        
        puts response.code
        if response.code == 200
          puts response.body
        end
  end
  
  def OrderClient.findOrderByEmail(email)
    base_uri 'http://localhost:8080'
  end
  
  def OrderClient.findOrderByCustomerId(customerId)
    base_uri 'http://localhost:8080'
  end
  
end




exit = false
while exit == false do
  puts "Select an option: addorder, additem, addcustomer, getorder, getitem, getcustomer, quit"
  option = gets.chomp
  
  case option
    when "addorder"
      
      puts "Input item id"
      itemId = gets.chomp
      puts "Input customer od"
      customerId = gets.chomp
      puts "Attempting to place order..."
      OrderClient.addEntry(itemId, customerId)

      
    when "additem"
      puts "Input item description"
      desc = gets.chomp
      puts "Input item price"
      price = gets.chomp
      puts "Input item stock quantity"
      qty = gets.chomp
      puts "Attempting to create new entry..."
      OrderClient.addItem(desc, price, qty)
      
    when "addcustomer"
      puts "Input last name"
      last = gets.chomp
      puts "Input first name"
      first = gets.chomp
      puts "Input email address"
      email = gets.chomp
      OrderClient.addCustomer(last, first, email)
      
    when "getorder" 
      invalid = true

      while invalid
        puts "Retrieve by: orderId, email, customerId, or quit"
        option2 = gets.chomp
        case option2
          when "orderId"
            #todo: search for order by id
            invalid = false
          when "email"
            #todo: search for orders by email
            invalid = false
          when "customerId"
            #todo: search for orders by customerid
            invalid = false
          else
            puts "Unrecognized option"
        end
      end
    
    when "getitem"
      puts "Input item id"
      id = gets.chomp
      OrderClient.findItemById(id)
      
    when "getcustomer" 
      valid = false

      while valid == false
        puts "Retrieve by: email, customerId, or quit"
        option2 = gets.chomp
        case option2
          when "email"
            puts "Input email"
            email = gets.chomp
            OrderClient.findCustomerByEmail(email)
            valid = true
          when "customerId"
            puts "Input id"
            id = gets.chomp
            OrderClient.findCustomerById(id)
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