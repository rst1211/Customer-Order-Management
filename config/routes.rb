Rails.application.routes.draw do

  get "sign-up", to: "registrations#new"
  post "sign-up", to: "registrations#create"

  root to: "main#index"
  
end
