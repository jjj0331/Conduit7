Rails.application.routes.draw do
  get 'sessions/new'
  root 'conduit#home'

  get 'conduit/register', to:'conduit#register', as: :register
  post 'conduit/create', to:'conduit#create'    , as: :create
  
end
