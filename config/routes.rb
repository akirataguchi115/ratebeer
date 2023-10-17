Rails.application.routes.draw do
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
	root 'breweries#index'
  get 'signup', to: 'users#new'
	get 'all_beers', to: 'beers#index'
  resource :session, only: [:new, :create, :destroy]
end
