Rails.application.routes.draw do
  resources :tasks
  resources :lists
  resources :notes
  resources :this_weeks
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
