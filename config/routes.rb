Rails.application.routes.draw do
  root to: 'home#index'

  resources :car_categories, only: [:index, :show, :new, :create, :edit, :update]
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
end
