Rails.application.routes.draw do

  devise_for :admins
  get 'welcome/index'

  resources :articles do
    resources :comments
  end

  resources :currencies

  root 'welcome#index'
  #get 'persons/profile', as: 'user_root'
end
