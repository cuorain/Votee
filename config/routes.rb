Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_scope :user do
    get '/signup' => 'devise/sessions#new'
  end
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
end
