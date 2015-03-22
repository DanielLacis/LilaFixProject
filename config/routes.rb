Rails.application.routes.draw do
  #new, create, edit, destroy, index, show, update
  #may need to nest some routes
  root to: 'sessions#new'
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :children, only: [] do
    resources :posts, only: [:new, :edit, :index]
  end
  resources :posts, except: [:new, :edit, :index]
  resources :comments, except: [:index, :show]
  resources :children
end
