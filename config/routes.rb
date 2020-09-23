Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :car_categories
  resources :subsidiaries, only: %i[index show new create edit update]
  resources :car_models, only: [:index, :show, :new, :create]
  resources :rentals, only: [:index, :show, :new, :create] do
    resources :car_rentals, only: [ :new, :create]
    get 'search', on: :collection
  end

  resources :car_rentals, only: [] do
    post 'finish', on: :member
  end
  
  resources :clients, only: [:index, :show, :new, :create]
  resources :cars, only: [:index, :show, :new, :create] do
    post 'maintanance', on: :member
    post 'available', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :cars, only: %i[index show create]
    end
  end
end