Rails.application.routes.draw do
  resources :carts do
		member do
			post 'checkout'
		end
	end
  resources :users
  root 'events#index'

  resources :events do
    resources :tickets

		member do
			post 'publish'
		end

		collection do
    	get 'mine'
  	end
  end

	resources :sessions, only: [:new, :create]
	delete 'logout' => 'sessions#destroy'
	resources :cart_item
end
