Rails.application.routes.draw do
  get 'conduit/home'
  get "up" => "rails/health#show", as: :rails_health_check

end
