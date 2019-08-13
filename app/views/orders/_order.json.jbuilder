json.extract! order, :id, :itemId, :customerId, :description, :price, :award, :total, :created_at, :updated_at
json.url order_url(order, format: :json)
