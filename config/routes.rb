Rails.application.routes.draw do
  resources :rooms
  resources :bookings
  get '/bookings', to: 'bookings#bookings'
  get '/index', to:'home#index'
  get '/rooms', to: 'rooms#rooms'
  root 'home#index'
  resources :bookings, only: [:new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
