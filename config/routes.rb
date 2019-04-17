Rails.application.routes.draw do

  resources :users
  resources :store_flavors
  resources :flavors
  resources :shift_jobs
  resources :jobs
  resources :shifts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #employee routes for scopes
  get "/employees/new" => "employees#new"
  get "/employees/managers" => "employees#managers"
  get "/employees/regulars" => "employees#regulars"
  get "/employees/admins" => "employees#admins"
  get "/employees/inactive" => "employees#inactive"
  get "/employees/active" => "employees#active"
  get "/employees/is_18_or_older" => "employees#is_18_or_older"
  get "/employees/younger_than_18" => "employees#younger_than_18"
  
  #employee routes for methods
  get "/employees/proper_name" => "employees#proper_name"

  #store routes
  get "/stores/inactive" => "stores#inactive"
  get "/stores/active" => "stores#active"

  #assignment routes
  get "/assignments/current" => "assignments#current"
  get "/assignments/past" => "assignments#past"
  get "/assignments/by_store" => "assignments#by_store"
  get "/assignments/by_employee" => "assignments#by_employee"
  get "/assignments/chronological" => "assignments#chronological"
  get "/assignments/for_store" => "assignments#for_store"
  get "/assignments/for_employee" => "assignments#for_employee"
  get "/assignments/for_pay_level" => "assignments#for_pay_level"
  get "/assignments/for_role" => "assignments#for_role"
  

  
  resources :stores
  resources :employees
  resources :assignments
  
end
