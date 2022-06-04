Rails.application.routes.draw do

  
  devise_for :users
  root "customers#index"
  get "/add-customer", to: "customers#new"
  post "/get-ajax-customer", to: "customers#ajaxCustomer"
  post "/add-customer", to: "customers#create"
  get "/show-customer/:id", to: "customers#show"





  get "/update-customer/:id", to: "customers#edit" , as: 'edit_customer'
  post "/update-customer", to: "customers#update"
  delete "/delete-customer/", to: "customers#delete"







  
  


  
end
