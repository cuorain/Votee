Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  devise_scope :user do
    get 'signup', to: 'users/registrations#new'
    post 'signup', to: 'users/registrations#create'
    get 'login', to: 'users/sessions#new'
    post 'login', to: 'users/sessions#create'
    delete 'logout', to: 'users/sessions#destroy'
  end

  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  resources :users, only: [:index, :show]
end
