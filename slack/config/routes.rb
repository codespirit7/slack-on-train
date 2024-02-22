Rails.application.routes.draw do
  resources :urls
  get "up" => "rails/health#show", as: :rails_health_check
  root to: redirect('/urls#index')
  post '/short-url', to: 'urls#create'
  post '/urls/:id', to: 'urls#show'  # Corrected route definition
  get '/short/:short_id', to: 'urls#redirect_short_url', as: 'short_url_redirect'
end
