Rails.application.routes.draw do
  resources :photos
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, :skip => [:registrations], :controllers => { :invitations => 'invitations' }
  as :user do
    get '/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch '/' => 'devise/registrations#update', :as => 'user_registration'
    put '/' => 'devise/registrations#update'
  end
  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
