Users::Engine.routes.draw do
  root 'users#index' #If only admins can check users index change root
  resources :users do
    collection do
      get :adminpanel
    end
    member do
      get :contacts, :disable
    end
  end

  resources :sessions, :only => [:new, :create, :destroy]
  resources :password_resets
  resources :usertypes
  resources :relationships, :only => [:create, :destroy]

  get '/signin', :to => 'sessions#new'
  get '/signout', :to => 'sessions#destroy'

end