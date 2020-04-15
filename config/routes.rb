Rails.application.routes.draw do
  # resources :blogs 
  get 'sessions/new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
  resources :blogs do
    collection do
      post :confirm
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end 
  get "users/user_favorites/:id" => "users#user_favorites", as: 'user_favorites'
end 
