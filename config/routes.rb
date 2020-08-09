Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/edit_password/:id', to: 'users#edit_password', as: "edit_password"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post 'votes/:id', to: 'votes#create', as: "votes"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :surveys
  resources :choices
  resources :votes
  get 'surveys/:id/results', to: 'surveys#results', as: "survey_result"
  get 'mysurveys/:id', to: 'surveys#my_survey', as: "my_survey"
  resources :relationships,       only: [:create, :destroy]
  get 'surveys/:id/results', to: 'surveys#search_reset', as: "search_reset"
end
