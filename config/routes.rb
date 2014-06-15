Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  root 'topics#index'
  get 'sign_in' => 'plurk#sign_in'
  delete 'sign_out' => 'plurk#sign_out'
  get 'plurk/callback'

  resources :users, only: :index do
    resources :topics
  end

  resources :topics do
    get :check, on: :collection
  end
end
