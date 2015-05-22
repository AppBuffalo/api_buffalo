Rails.application.routes.draw do
  apipie

  root 'apipie/apipies#index'

  ### Users ###
  get '/users',             to: 'users#show'
  post '/users',            to: 'users#create'
  get '/users/:user_id/shows',   to: 'users#shows'
  post '/users/:user_id/shows',  to: 'users#add_show'

  ### Shows ###
  get '/shows/last',        to: 'shows#last'
  get '/shows/top',         to: 'shows#top'
end
