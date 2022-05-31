Rails.application.routes.draw do

  
  devise_for :users
  root "customers#index"
  post "/get-ajax", to: "customers#ajaxIndex"
  get "/add-customer", to: "customers#new"
  post "/add-customer", to: "customers#create"
  get "/show-customer/:id", to: "customers#show"





  get "/update-customer/:id", to: "customers#edit"
  post "/update-customer", to: "customers#update"
  delete "/delete-customer/", to: "customers#delete"







  
  


  
end
