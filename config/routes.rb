Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :comments, only: [:create, :destroy]
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
  get '/users/most_active', to: 'users#most_active'
end
