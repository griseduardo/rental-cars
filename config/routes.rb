Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :car_categories
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_models, only: [:index, :show, :new, :create]
  resources :rentals, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
  end
  resources :clients, only: [:index, :show, :new, :create]
  resources :cars, only: [:index, :show, :new, :create]
end
