Rails.application.routes.draw do
  resources :lists do 
    resources :tasks, except: [:index]
  end
  get "finishedies", to: "lists#finishedies"
  root 'lists#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
