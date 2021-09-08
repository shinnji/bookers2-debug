Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]do
    resource :relationships, only: [:create, :destroy]
  get :followings, on: :member
  get :followers, on: :member
  end 
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  get '/search', to: 'searchs#search'
end