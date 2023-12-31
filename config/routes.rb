Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
	root 'breweries#index'
  get 'signup', to: 'users#new'
	get 'all_beers', to: 'beers#index'
	get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resource :session, only: [:new, :create, :destroy]
end
