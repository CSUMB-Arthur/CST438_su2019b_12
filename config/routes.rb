Rails.application.routes.draw do
  #resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'orders', to: 'orders#create'
  get 'orders/:id', to: 'orders#retrieveById'
  get 'orders', to: 'orders#retrieveByOther'
  #/orders?customerId=nnn
  #/orders?email=nn@nnnn
end
