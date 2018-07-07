Rails.application.routes.draw do

devise_for :users, :controllers => {:registrations => "registrations"}

# this is so when we open our root page of the website, Rails knows which controller and its action to call
  root to: 'pages#index'

# this is shortening the path to /login
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

# this is shortening the path to /signup
  devise_scope :user do
  get 'signup', to: 'devise/registrations#new'
end

# this is creating paths to categories in seed.rb
resources :posts do
  collection do
    get 'inspiration'
    get 'recipes'
    get 'tiugirls'
  end
end


namespace :group do
  resources :conversations do
    member do
      post :close
      post :open
    end
  end
  resources :messages, only: [:index, :create]
end

namespace :private do
  resources :conversations, only: [:create] do
    member do
      post :close
      post :open
    end
  end
  resources :messages, only: [:index, :create]
end

resources :contacts, only: [:create, :update, :destroy]

end
