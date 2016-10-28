Rails.application.routes.draw do
  resources :carts
  resources :users
  root 'events#index'

  resources :events do
    resources :tickets
  end
	resources :sessions, only: [:new, :create]
	delete 'logout' => 'sessions#destroy'
	resources :cart_item, only: [:new, :create]
end
