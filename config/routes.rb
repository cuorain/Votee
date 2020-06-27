Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/edit_password/:id', to: 'users#edit_password', as: "edit_password"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :surveys
end
