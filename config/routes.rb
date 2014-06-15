Rails.application.routes.draw do
  root 'topics#index'

  # pages
  controller :pages do
    get :about
    get :faq
  end

  # auth
  get 'sign_in' => 'plurk#sign_in'
  delete 'sign_out' => 'plurk#sign_out'
  get 'plurk/callback'

  resources :users, only: [] do
    resources :topics
    get :search, on: :collection
  end

  resources :topics do
    get :check, on: :collection
  end

  namespace :api do
    get :robot
  end
end
