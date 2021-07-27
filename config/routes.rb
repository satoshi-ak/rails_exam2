Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :pictures do
  resources :comments, only: [:create] 
    collection do
      post :confirm
    end
  end
end
