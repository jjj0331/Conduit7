Rails.application.routes.draw do
  root 'conduit#home'

  get 'conduit/register', to:'conduit#register', as: :register
  
end
