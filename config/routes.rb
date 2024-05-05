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

  namespace :api do
    namespace :v1 do
      post '/users',       to: 'users#create'
      post '/users/login', to: 'users#login'
    end
  end

  namespace :api do
    namespace :v1 do
      get  '/api/user'           ,to: 'api#show'
      post '/api/articles'       ,to: 'api#create'

      get   '/api/articles/:id' ,to: 'api#get'
      put   '/api/articles/:id' ,to: 'api#update'
      delete'/api/articles/:id' ,to: 'api#delete'
    end
  end  
  
end
