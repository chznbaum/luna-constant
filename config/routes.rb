Rails.application.routes.draw do
  resources :photos do
    resources :comments
  end
  resources :comments do
    resources :comments
  end

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, :skip => [:registrations], :controllers => { :invitations => 'invitations' }, constraints: {protocol: /https/}
  as :user do
    get '/edit' => 'devise/registrations#edit', :as => 'edit_user_registration', constraints: {protocol: /https/}
    patch '/' => 'devise/registrations#update', :as => 'user_registration', constraints: {protocol: /https/}
    put '/' => 'devise/registrations#update', constraints: {protocol: /https/}
  end
  
  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
