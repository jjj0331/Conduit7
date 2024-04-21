Rails.application.routes.draw do
  get 'sessions/new'
  root 'conduit#home'

  get 'conduit/register', to:'conduit#register', as: :register
  post 'conduit/create',  to:'conduit#create',   as: :create

  get    '/login',    to:'sessions#new'
  post   '/login',    to:'sessions#create'
  delete '/login',    to:'sessions#destroy'

  get 'conduit/CreateArticle',to:'conduit#CreateArticle'
  get 'conduit/Settings',to:'conduit#Settings'

  get 'conduit/profile',to:'conduit#profile'
  get 'conduit/profile/:id',to:'conduit#profile'
  get 'conduit/article/:id', to: 'conduit#article'


end
