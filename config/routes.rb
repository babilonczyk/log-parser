Rails.application.routes.draw do

  resources :results, only: [:index]

  root to: "results#index"
end 
