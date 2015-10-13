Rails.application.routes.draw do
  get 'users/new'

  get 'signup' => 'users#new'

  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  root 'static_pages#home'
end
