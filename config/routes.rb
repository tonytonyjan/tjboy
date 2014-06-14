Rails.application.routes.draw do
  root 'topics#index'
  get 'sign_in' => 'plurk#sign_in'
  get 'sign_out' => 'plurk#sign_out'
  get 'plurk/callback'
  resources :topics do
    get :check, on: :collection
  end
end
