Rails.application.routes.draw do
  resources :users
  root 'static_pages#home'
  #rajout routes
  post '/users/new',  to: 'users#create'
  post '/users/:id/edit', to: 'users#edit'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
