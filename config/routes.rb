Rails.application.routes.draw do


  namespace :api do 
    namespace :v1 do
      resources :users, only: [:show, :index, :create]
      get 'users/login/:username', to: 'users#login'
      resources :tasks, only: [:show, :create, :index, :destroy]
      resources :lists, only: [:show, :create, :index, :destroy]
      resources :notes, only: [:show, :create, :update]
      resources :this_weeks, only: [:show, :create, :update]
    end
  end

  
end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html