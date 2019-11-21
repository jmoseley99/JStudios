Rails.application.routes.draw do
  resources :bookings
  resources :rooms
  get '/contacts', to: 'contacts#contact'
  get '/bookings', to: 'bookings#bookings'
  get '/index', to:'home#index'
  get '/rooms', to: 'rooms#rooms'
  root 'home#index'
  resources :contacts, only: [:contact, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
