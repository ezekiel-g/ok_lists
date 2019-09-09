Rails.application.routes.draw do
  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	root 'pages#index'
  	
  	devise_for :users

  	namespace :api do
		namespace :v1 do
			resources :users, only: [:index, :show, :destroy]
			resources :lists
			resources :armies
			resources :units
		end
	end
end
