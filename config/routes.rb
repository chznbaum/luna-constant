Rails.application.routes.draw do
  resources :photos do
    resources :comments
    resources :likes
    member do
      get :toggle_status
    end
  end
  resources :comments do
    resources :comments
    resources :likes
  end

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, :skip => [:registrations], :controllers => { :invitations => 'invitations' }, :protocol => "https"
  as :user do
    get '/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch '/' => 'devise/registrations#update', :as => 'user_registration'
    put '/' => 'devise/registrations#update'
  end

  get '/users/index', to: 'users#index', :as => 'users'

  get '/request-invitation', to: 'requests#new', as: 'new_request'
  post '/request-invitation', to: 'requests#create', as: 'create_request'

  get '/faq', to: 'pages#faq', as: 'faq'

  resources :tickets do
    post '/', to: 'ticket_messages#create', as: 'create_ticket_message'
  end

  post '/new_ticket' => 'tickets#new_ticket'
  get '/ticket_close' => 'tickets#close_ticket'
  get '/ticket_open' => 'tickets#open_ticket'
  
  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
