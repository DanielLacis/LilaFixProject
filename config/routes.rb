Rails.application.routes.draw do
  #new, create, edit, destroy, index, show, update
  #may need to nest some routes
  root to: 'sessions#new'
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :posts, except: :index
  resources :comments, except: [:index, :show]
  resources :children
end
