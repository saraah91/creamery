Rails.application.routes.draw do
  resources :stores
  resources :employees
  resources :assignments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Set the root url
  root to: 'assignments#index', as: :home
  resources :employees

end
