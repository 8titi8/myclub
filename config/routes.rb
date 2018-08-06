Rails.application.routes.draw do
  resources :users
  root 'static_pages#home'
  #rajout routes
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'
end
