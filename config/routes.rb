Rails.application.routes.draw do
  apipie

  root 'apipie/apipies#index'

  ### Users ###
  post '/users/:user_id/like/:photo_id',    to: 'users#like'
  post '/users/:user_id/dislike/:photo_id', to: 'users#dislike'
  get '/users',                             to: 'users#show'
  post '/users',                            to: 'users#create'

  ### Photos ###
  resources :photos
end
