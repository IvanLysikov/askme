Rails.application.routes.draw do

  # post '/questions', to: 'questions#create'
  # patch '/questions/:id', to: 'questions#update'
  # delete '/question/:id', to: 'questions#destroy'

  root to: 'questions#index'
  resources :questions

  resource :session, only: %i[new create destroy]
  # get 'users/new'
  # get 'users/create'
  resources :users, only: %i[new create]
end
