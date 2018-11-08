Rails.application.routes.draw do
  root to: 'home#index'
  post '/', to: 'home#index'

  get '/devises', to: 'home#get_all'
  post '/movies-by-name', to: 'home#get_movies_by_name'
  post '/devise-by-name', to: 'home#get_devise_by_name'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
