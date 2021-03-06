Rails.application.routes.draw do

  post 	'login'	     =>	'sessions#create'
  delete 'logout'	     =>	'sessions#destroy'
  get       'login'	     =>	'sessions#new'
  get       'signup'     =>	'users#new'
  get       'help' 	     =>	'static_pages#help'
  get       'about'      =>	'static_pages#about'
  get       'contact'    =>	'static_pages#contact'

  root 'static_pages#home'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts,		only: [ :create, :destroy]
  resources :relationships,    only: [:create, :destroy]
end
