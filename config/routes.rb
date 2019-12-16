Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :bookings
  resources :rooms
  resources :contacts, only: [:contact, :create]

  get '/contacts', to: 'contacts#contact'
  get '/bookings', to: 'bookings#bookings'
  get '/index', to:'home#index'
  get '/rooms', to: 'rooms#rooms'
  root 'home#index'
end
