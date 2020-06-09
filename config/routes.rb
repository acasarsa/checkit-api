Rails.application.routes.draw do


  namespace :api do 
    namespace :v1 do
      resources :users, only: [:index, :create, :show] do 
        resources :lists, only: [:create, :update, :index, :show, :destroy] do
          resources :tasks, only: [:create, :index, :update, :show, :destroy]
        end

        # resources :tasks, only: [:index]
        resources :notes, only: [:create, :update]
        resources :this_weeks, only: [:create, :update]
      end
      get 'users/login/:username', to: 'users#login'
    end
  end

  
end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html