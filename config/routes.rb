Rails.application.routes.draw do
  #resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'orders', to: 'order#create'
  get 'orders/:id', to: 'order#retrieveById'
  get 'orders', to: 'order#retrieveByOther'
  #/orders?customerId=nnn
  #/orders?email=nn@nnnn
end
