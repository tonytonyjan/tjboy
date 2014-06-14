Rails.application.routes.draw do
  root 'topics#index'
  resources :topics do
    get :check, on: :collection
  end
end
