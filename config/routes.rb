Rails.application.routes.draw do
  resources :bookings
  get '/bookings', to: 'bookings#bookings'
  get '/index', to:'home#index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
