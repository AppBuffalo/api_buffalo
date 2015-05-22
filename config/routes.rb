Rails.application.routes.draw do
  apipie

  root 'apipie/apipies#index'

  ### Users ###
  get '/users',             to: 'users#show'
  post '/users',            to: 'users#create'

end
