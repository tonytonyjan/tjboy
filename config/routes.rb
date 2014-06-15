Rails.application.routes.draw do
  root 'topics#index'
  get 'sign_in' => 'plurk#sign_in'
  delete 'sign_out' => 'plurk#sign_out'
  get 'plurk/callback'
  resources :topics do
    get :check, on: :collection
  end
end
