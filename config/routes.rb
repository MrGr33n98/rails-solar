
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :products
      resources :categories
      resources :users
      resources :posts
      resources :comments
    end
  end
  # ...existing code...
end