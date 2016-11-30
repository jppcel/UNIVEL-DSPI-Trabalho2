Rails.application.routes.draw do
  resources :senhas
  resources :setors
  root 'index#index'
  devise_for :users

  get '/api/call', to: 'senhas#call'
  get '/api/callNext', to: 'senhas#callNext'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
